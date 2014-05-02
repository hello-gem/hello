module Hello
  class Config
    class Base

      def config(&block)
        @scope = "#{full_klass_name}::Scope".constantize.new
        @scope.instance_eval(&block)
      end


      
      def self.has_scopes(*scope_names)
        self.const_set("Scope", fabricate_scope_class)

        scope_names.each do |scope_name|
          define_method scope_name do
            get_scope.get(scope_name) || raise("no #{scope_name} block")
          end
        end
      end

      def self.fabricate_scope_class
        Class.new do
          def set(name, &block)
            blocks[name] = block
          end

          def get(name)
            blocks[name]
          end

          private

          def blocks
            @blocks ||= {}
          end
        end
      end



      private

          def get_scope
            reload && @scope
          end

              def reload
                ensure_config_file
                load(config_file)
                self
              end

                  def ensure_config_file
                    unless File.exists? config_file
                      #`rails g hello:install`
                      raise "should have config #{filename} file"
                    end
                  end
                      
                      def config_file
                        ::Rails.root.join "app/lib/hello/#{filename}.rb"
                      end

              
              def filename
                klass_name.underscore
              end

                  def klass_name
                    @klass_name ||= full_klass_name.split('::').last
                  end

                      def full_klass_name
                        self.class.name
                      end


    end
  end
end