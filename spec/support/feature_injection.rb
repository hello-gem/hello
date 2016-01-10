module RSpec
  def self.bdd
    Bdd::FeatureInjection.instance
  end
end

module Bdd
  class FeatureInjection
    include Singleton

    def capability(s, *metadata, &example_group_block)
      data = get_data(*metadata, &example_group_block)
      s_vision = format('Vision', data['vision'])
      RSpec.describe(s_vision, *metadata) do
        goal data['goal'] do
          capability s, type: :feature, &example_group_block
        end
      end
    end

    def uic(s, *metadata, &example_group_block)
      data = get_data(*metadata, &example_group_block)
      s_vision = format('Vision', data['vision'])
      RSpec.describe(s_vision, *metadata) do
        goal data['goal'] do
          capability data['capability'] do
            uic s, type: :feature, &example_group_block
          end
        end
      end
    end

    def api(s, *metadata, &example_group_block)
      data = get_data(*metadata, &example_group_block)
      s_vision = format('Vision', data['vision'])
      RSpec.describe(s_vision, *metadata) do
        goal data['goal'] do
          capability data['capability'] do
            api s, type: :request, &example_group_block
          end
        end
      end
    end

    def get_data(*_metadata, &example_group_block)
      data = Hash.new('-')

      # data = LOAD bdd.yml files from parent folders into
      p = Pathname(example_group_block.source_location.first)
      # data['feature'] = s
      loop do
        break if p.to_s.ends_with? '/spec'
        r = p.join('bdd.yml')
        data.reverse_merge!(YAML.load_file(r)) if r.exist?
        p = p.parent
        xxx = p.join('support.rb')
        xxx.exist? && load(xxx)
      end
      data
    end

    def format(s1, s2)
      [s1.underline.light_white, s2].join(': ')
    end
  end

  module RSpec
    module ExampleGroups
      def dig_context(k, v, *args, &b)
        context(::RSpec.bdd.format(k, v), *args, &b)
      end

      def the_context(s, *args, &b)
        context(::RSpec.bdd.format('Context', s), *args, &b)
      end

      def vision(s, *args, &b)
        context(::RSpec.bdd.format('Vision', s), *args, &b)
      end

      def goal(s, *args, &b)
        context(::RSpec.bdd.format('Goal', s), *args, &b)
      end

      def capability(s, *args, &b)
        context(::RSpec.bdd.format('Capability', s), *args, &b)
      end

      def feature(s, *args, &b)
        context(::RSpec.bdd.format('Feature', s), *args, &b)
      end

      def api(s, *args, &b)
        context(::RSpec.bdd.format('Interface', s), *args, &b)
      end

      def uic(s, *args, &b)
        context(::RSpec.bdd.format('Component', s), *args, &b)
      end

      def role(s, *args, &b)
        context(::RSpec.bdd.format('Role', s), *args, &b)
      end

      def story(s, *args, &b)
        context(::RSpec.bdd.format('Story', s), *args, &b)
      end

      def scenario(s, *args, &b)
        super(::RSpec.bdd.format('Scenario', s), *args, &b)
      end
    end
  end
end

RSpec.configure do |config|
  config.extend Bdd::RSpec::ExampleGroups
end
