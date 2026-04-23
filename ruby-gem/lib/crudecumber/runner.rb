# frozen_string_literal: true

require_relative 'parser'
require_relative 'pass_fail'
require_relative 'display'
require_relative 'reporter'

module Crudecumber
  class Runner
    def self.run(argv)
      new(argv).run
    end

    def initialize(argv)
      @args    = argv.dup
      @verbose = @args.delete('--v') || @args.delete('-v') || @args.delete('--verbose')
      @tags    = extract_tags
      @paths   = @args.empty? ? ['features'] : @args
    end

    def run
      files = feature_files
      if files.empty?
        warn "No .feature files found in: #{@paths.join(', ')}"
        exit 1
      end

      results = []
      files.each { |f| process_file(f, results) }

      path = Reporter.generate(results)
      puts "\nView results at file:///#{Dir.pwd}/#{path}"
    end

    private

    def extract_tags
      tags = []
      remaining = []
      i = 0
      while i < @args.length
        if @args[i] == '-t' || @args[i] == '--tags'
          tag = @args[i + 1]&.delete_prefix('@')
          tags << tag if tag
          i += 2
        else
          remaining << @args[i]
          i += 1
        end
      end
      @args = remaining
      tags
    end

    def feature_files
      @paths.flat_map do |path|
        if File.directory?(path)
          Dir.glob("#{path}/**/*.feature").sort
        elsif File.file?(path) && path.end_with?('.feature')
          [path]
        else
          []
        end
      end
    end

    def process_file(path, results)
      feature_file = Parser.new.parse_file(path)
      feature      = feature_file.feature

      scenarios = filter_by_tags(feature)
      return if scenarios.empty?

      puts Display.feature_header(feature.name, feature.tags)
      puts

      scenarios.each do |scenario|
        case scenario
        when Scenario
          results << run_scenario(feature, scenario, feature.background)
        when ScenarioOutline
          expand_outline(scenario).each do |expanded|
            results << run_scenario(feature, expanded, feature.background)
          end
        end
      end
    end

    def filter_by_tags(feature)
      return feature.scenarios if @tags.empty?

      feature.scenarios.select do |scenario|
        all_tags = (feature.tags + scenario.tags).map { |t| t.delete_prefix('@') }
        @tags.any? { |required| all_tags.include?(required) }
      end
    end

    def expand_outline(outline)
      header = outline.examples.header
      outline.examples.rows.map do |row|
        subs = header.zip(row).to_h
        expanded_steps = outline.steps.map do |step|
          expanded_text = step.text.gsub(/<(\w+)>/) { subs[$1] || "<#{$1}>" }
          Step.new(keyword: step.keyword, text: expanded_text, multiline: step.multiline)
        end
        Scenario.new(
          name:  "#{outline.name} (#{row.join(', ')})",
          tags:  outline.tags,
          steps: expanded_steps
        )
      end
    end

    def run_scenario(feature, scenario, background)
      puts Display.scenario_header(scenario.name, scenario.tags)
      step_results = []

      background&.steps&.each { |step| step_results << run_step(step) }
      scenario.steps.each     { |step| step_results << run_step(step) }

      puts
      ScenarioResult.new(
        feature_name:  feature.name,
        scenario_name: scenario.name,
        tags:          scenario.tags,
        step_results:  step_results
      )
    end

    def run_step(step)
      print Display.step_pending(step)
      $stdout.flush

      key    = PassFail.capture
      status = if PassFail.pass?(key) then :pass
               elsif PassFail.skip?(key) then :skip
               else :fail
               end

      Display.clear_step(step)

      note = nil
      if status == :fail
        print '    Describe the problem: '
        $stdout.flush
        note = $stdin.gets&.chomp
        print "\e[1A\r\e[K"
      end

      puts Display.step_result(step, status, note)
      StepResult.new(keyword: step.keyword, text: step.text, status: status, note: note)
    end
  end
end
