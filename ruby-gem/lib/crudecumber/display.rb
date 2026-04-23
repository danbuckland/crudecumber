# frozen_string_literal: true

module Crudecumber
  module Display
    RESET  = "\e[0m"
    BOLD   = "\e[1m"
    GREEN  = "\e[32m"
    RED    = "\e[31m"
    YELLOW = "\e[33m"
    CYAN   = "\e[36m"

    STATUS_COLOR = { pass: GREEN, fail: RED, skip: YELLOW }.freeze
    STATUS_LABEL = { pass: 'passed', fail: 'FAILED', skip: 'skipped' }.freeze

    def self.feature_header(name, tags)
      tag_line = tags.empty? ? '' : "#{CYAN}#{tags.join(' ')}#{RESET}\n"
      "#{tag_line}#{BOLD}Feature: #{name}#{RESET}"
    end

    def self.scenario_header(name, tags)
      tag_line = tags.empty? ? '' : "  #{CYAN}#{tags.join(' ')}#{RESET}\n"
      "#{tag_line}  #{BOLD}Scenario: #{name}#{RESET}"
    end

    def self.step_pending(step)
      "    #{step.keyword} #{step.text}#{multiline_text(step.multiline)}\n"
    end

    def self.step_result(step, status, note = nil)
      color = STATUS_COLOR[status]
      label = STATUS_LABEL[status]
      line  = "    #{color}#{step.keyword} #{step.text} (#{label})#{RESET}"
      note ? "#{line}\n      Note: #{note}" : line
    end

    def self.clear_step(step, extra_lines: 0)
      n = line_count(step) + extra_lines
      print "\e[#{n}A\r\e[J"
    end

    def self.line_count(step)
      1 + multiline_line_count(step.multiline)
    end

    def self.multiline_text(multiline)
      case multiline
      when DataTable
        rows = multiline.rows.map { |r| "      | #{r.join(' | ')} |" }
        "\n#{rows.join("\n")}"
      when DocString
        content = multiline.content.each_line.map { |l| "      #{l.chomp}" }.join("\n")
        "\n      \"\"\"\n#{content}\n      \"\"\""
      else
        ''
      end
    end

    def self.multiline_line_count(multiline)
      case multiline
      when DataTable  then multiline.rows.length
      when DocString  then multiline.content.lines.count + 2
      else 0
      end
    end
  end
end
