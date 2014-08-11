require "hello/config/master"

module Hello
  class Config
    include Singleton
    
    def config_for(name, &block)
      v = pool[name] ||= Master.new(name)
      block_given? ? v.write(&block) : v.read
    end

    private

    def pool
      @pool ||= {}
    end





    class Master

      def initialize(name)
        @filename = name
      end

      def write(&block)
        # puts "write"
        @scope.instance_eval(&block)
      end

      def read
        # puts "read"
        get_scope
      end


      class Scope
        attr_reader :success_block, :failure_block, :fields

        def permitted_fields(*the_fields)
          @fields = the_fields
        end

        def success_strategy(&block)
          @success_block = block
        end

        def failure_strategy(&block)
          @failure_block = block
        end
      end


      private

          def get_scope
            @scope ||= Scope.new
            reload
            @scope
          end

              def reload
                ensure_config_file
                load(config_file)
                self
              end

                  def ensure_config_file
                    unless File.exists? config_file
                      #`rails g hello:install`
                      raise "should have config #{@filename} file"
                    end
                  end

                      def config_file
                        ::Rails.root.join "app/lib/hello/#{@filename}_strategy.rb"
                        # ::Rails.root.join "config/hello/#{@filename}.rb"
                      end

    end



  end
end
