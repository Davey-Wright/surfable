class CustomFormatter < RSpec::Core::Formatters::DocumentationFormatter
  RSpec::Core::Formatters.register self

  def initialize(output)
    @output = output
    @group_level = 0
    @section_messages = []
  end

  def example_section_finished(notification)
    @section_messages << passed_output(notification.name.strip)
  end

  def example_group_finished(notification)
    @group_level -= 1 if @group_level > 0
    @section_messages.each { |message| @output.puts message }
    @section_messages = []
  end

  private

    def passed_output(example)
      format_output(example, 'Passed', :success)
    end

    def pending_output(example, _message)
      format_output(example, 'Pending', :pending)
    end

    def failure_output(example)
      format_output(example, 'Failed', :failure)
    end

    def format_output(example, status_text, code_or_symbol)
      RSpec::Core::Formatters::ConsoleCodes.wrap(
        "#{current_indentation}#{example.description.strip} (#{status_text})",
        code_or_symbol
      )
    end
end
