# https://raw.githubusercontent.com/rspec/rspec-core/v3.2.2/lib/rspec/core/formatters/documentation_formatter.rb
# require "rspec/core/formatters/documentation_formatter"

RSpec::Support.require_rspec_core "formatters/base_text_formatter"

class RSpec::Core::ExampleGroup
  def step(msg)
    m = RSpec.current_example.metadata
    
    if block_given?
      # m[:step_messages] << msg #if m[:step_messages]
      if @is_during_rspec_step
        yield
      else
        m[:step_messages] << msg
        @is_during_rspec_step = true
        yield
        @is_during_rspec_step = false
      end
    else
      m[:step_messages] << "SKIPPED #{msg}"
    end
  end

  def Given(msg, &block)
    step("Given #{msg}", &block)
  end

  def When(msg, &block)
    step("When  #{msg}", &block)
  end

  def Then(msg, &block)
    step("Then  #{msg}", &block)
  end
end


module RSpec
  module Core
    module Formatters
      # @private
      class DocumentationFormatter < BaseTextFormatter
        Formatters.register self
        # , :example_group_started, :example_group_finished,
        #                     :example_passed, :example_pending, :example_failed

        def initialize(output)
          super
          @group_level = 0
        end


        def example_started(notification)
          notification.example.metadata[:step_messages] = []
        end

        def example_group_started(notification)
          output.puts if @group_level == 0
          output.puts "#{current_indentation}#{notification.group.description.strip}"

          @group_level += 1
        end

        def example_group_finished(_notification)
          @group_level -= 1
        end

        def example_passed(passed)
          output.puts passed_output(passed.example)
          output.puts read_steps(passed.example, :success)
        end

        def example_pending(pending)
          output.puts pending_output(pending.example,
                                     pending.example.execution_result.pending_message)
          output.puts read_steps(pending.example, :pending)
        end

        def example_failed(failure)
          output.puts failure_output(failure.example,
                                     failure.example.execution_result.exception)
          output.puts read_steps(failure.example, :failure)
        end

      private

        def read_steps(example, color)
          example.metadata[:step_messages].map do |msg|
            # output.puts detail_color("#{'  ' * (@group_level + 1)}#{msg}")
            ConsoleCodes.wrap("#{next_indentation}- #{msg}", color)
            # "#{next_indentation}#{msg}"
          end
        end


        def passed_output(example)
          ConsoleCodes.wrap("#{current_indentation}#{example.description.strip}", :success)
        end

        def pending_output(example, message)
          ConsoleCodes.wrap("#{current_indentation}#{example.description.strip} " \
                            "(PENDING: #{message})",
                            :pending)
        end

        def failure_output(example, _exception)
          ConsoleCodes.wrap("#{current_indentation}#{example.description.strip} " \
                            "(FAILED - #{next_failure_index})",
                            :failure)
        end

        def next_failure_index
          @next_failure_index ||= 0
          @next_failure_index += 1
        end

        def current_indentation
          '  ' * @group_level
        end

        def next_indentation
          '  ' * (@group_level+1)
        end

        def example_group_chain
          example_group.parent_groups.reverse
        end
      end
    end
  end
end
