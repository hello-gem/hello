# This migration comes from hello (originally 3)
class CreateUsers < ActiveRecord::Migration
  def change
    must_create_user_table = !table_exists?(:users)
    create_table(:users) { |t| t.timestamps } if must_create_user_table
    
    add_users_column_safe :name, :string
    add_users_column_safe :role, :string
    add_users_column_safe :locale, :string
    add_users_column_safe :time_zone, :string
    add_users_column_safe :credentials_count,     :integer, default: 0
    add_users_column_safe :access_tokens_count, :integer, default: 0
    add_users_column_safe :city, :string
  end

  private

      def add_users_column_safe(column_name, type, options={})
        return if column_exists?(:users, column_name)
        add_column(:users, column_name, type, options)
      end
end
