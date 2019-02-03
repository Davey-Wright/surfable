module ExampleSections
  def section(name)
    RSpec.configuration.reporter.publish(:example_section_started, :name => name)
    yield
  ensure
    RSpec.configuration.reporter.publish(:example_section_finished, :name => name)
  end
end

# RSpec.configure { |config| config.include ExampleSections }
