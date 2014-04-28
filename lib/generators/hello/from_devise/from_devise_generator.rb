require "rails/generators/active_record"

class Hello::FromDeviseGenerator < ActiveRecord::Generators::Base
  # ActiveRecord::Generators::Base inherits from Rails::Generators::NamedBase which requires a NAME parameter for the
  # new table name. Our generator doesn't need it.
  argument :name, type: :string, default: 'not-needed'


  source_root File.expand_path('../templates', __FILE__)

  def create_the_migration
    migration_template "from_devise.migration.rb", "db/migrate/from_devise.hello.rb"
  end
end
