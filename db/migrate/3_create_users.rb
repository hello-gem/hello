class CreateUsers < ActiveRecord::Migration
  def change
    must_create_user_table = !table_exists?(:users)
    create_table(:users) { |t| t.timestamps } if must_create_user_table
    
    add_users_column_safe :name, :string
    add_users_column_safe :role, :string, default: 'user'
    add_users_column_safe :identities_count, :integer, default: 0
    add_users_column_safe :sessions_count,   :integer, default: 0
  end

  private

      def add_users_column_safe(column_name, type, options={})
        return if column_exists?(:users, column_name)
        add_column(:users, column_name, type, options)
      end
end
