# frozen_string_literal: true

module Crudecumber
  FeatureFile     = Data.define(:path, :feature)
  Feature         = Data.define(:name, :tags, :background, :scenarios)
  Background      = Data.define(:steps)
  Scenario        = Data.define(:name, :tags, :steps)
  ScenarioOutline = Data.define(:name, :tags, :steps, :examples)
  Examples        = Data.define(:header, :rows)
  Step            = Data.define(:keyword, :text, :multiline)
  DataTable       = Data.define(:rows)
  DocString       = Data.define(:content)

  class Parser
    STEP_RE = /\A(Given|When|Then|And|But)\s+(.*)\z/

    def parse_file(path)
      FeatureFile.new(path: path, feature: parse(File.read(path, encoding: 'UTF-8')))
    end

    def parse(source)
      reset!
      source.each_line.map(&:rstrip).each { |line| process(line) }
      finalize_current
      background = @items.find { |i| i.is_a?(Background) }
      Feature.new(
        name:       @feature_name || '',
        tags:       @feature_tags,
        background: background,
        scenarios:  @items.reject { |i| i.is_a?(Background) }
      )
    end

    private

    def reset!
      @feature_name    = nil
      @feature_tags    = []
      @pending_tags    = []
      @items           = []
      @current         = nil
      @in_docstring    = false
      @docstring_lines = []
      @docstring_indent = ''
    end

    def process(line)
      stripped = line.strip

      if @in_docstring
        process_docstring_line(line, stripped)
        return
      end

      return if stripped.empty? || stripped.start_with?('#')

      if stripped.start_with?('@')
        @pending_tags += stripped.scan(/@[\w:]+/)
      elsif stripped.start_with?('Feature:')
        @feature_name = stripped.delete_prefix('Feature:').strip
        @feature_tags = @pending_tags.dup
        @pending_tags = []
      elsif stripped.start_with?('Background:')
        start_section(:background)
      elsif stripped.match?(/\AScenario (?:Outline|Template):/i)
        name = stripped.sub(/\AScenario (?:Outline|Template):\s*/i, '')
        start_section(:outline, name: name)
      elsif stripped.match?(/\A(?:Scenario|Example):/)
        name = stripped.sub(/\A(?:Scenario|Example):\s*/, '')
        start_section(:scenario, name: name)
      elsif stripped.match?(/\AExamples:|Scenarios:/)
        @current[:examples_started] = true if @current
      elsif stripped.start_with?('|')
        handle_table_row(stripped)
      elsif stripped.start_with?('"""') || stripped.start_with?("'''")
        @in_docstring     = true
        @docstring_lines  = []
        @docstring_indent = line[/\A\s*/]
      elsif (m = stripped.match(STEP_RE))
        @current[:steps] << build_raw_step(m[1], m[2]) if @current
      end
    end

    def process_docstring_line(line, stripped)
      if stripped.start_with?('"""') || stripped.start_with?("'''")
        @in_docstring = false
        if @current && @current[:steps].any?
          @current[:steps].last[:docstring] = DocString.new(content: @docstring_lines.join("\n"))
        end
      else
        @docstring_lines << line.delete_prefix(@docstring_indent)
      end
    end

    def start_section(type, name: nil)
      finalize_current
      @current = { type: type, name: name, tags: @pending_tags.dup, steps: [],
                   examples_rows: [], examples_started: false }
      @pending_tags = []
    end

    def handle_table_row(stripped)
      return unless @current

      cells = stripped.split('|').map(&:strip).reject(&:empty?)

      if @current[:examples_started] && @current[:type] == :outline
        @current[:examples_rows] << cells
      elsif @current[:steps].any?
        last = @current[:steps].last
        last[:table] ? last[:table] << cells : last[:table] = [cells]
      end
    end

    def build_raw_step(keyword, text)
      { keyword: keyword, text: text, table: nil, docstring: nil }
    end

    def finalize_current
      return unless @current

      steps = @current[:steps].map do |s|
        multiline = s[:table] ? DataTable.new(rows: s[:table]) : s[:docstring]
        Step.new(keyword: s[:keyword], text: s[:text], multiline: multiline)
      end

      @items << case @current[:type]
                when :background
                  Background.new(steps: steps)
                when :scenario
                  Scenario.new(name: @current[:name], tags: @current[:tags], steps: steps)
                when :outline
                  rows = @current[:examples_rows]
                  examples = rows.empty? ? Examples.new(header: [], rows: []) :
                                           Examples.new(header: rows.first, rows: rows[1..])
                  ScenarioOutline.new(name: @current[:name], tags: @current[:tags],
                                      steps: steps, examples: examples)
                end
      @current = nil
    end
  end
end
