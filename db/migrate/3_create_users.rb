class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users, &:timestamps) if !table_exists?(:users)

    add_users_column_safe :name,      :string

    add_users_column_safe :role,      :string, default: 'onboarding'
    add_users_column_safe :locale,    :string
    add_users_column_safe :time_zone, :string
    add_users_column_safe :username,  :string

    add_users_column_safe :credentials_count,   :integer, default: 0
    add_users_column_safe :accesses_count,      :integer, default: 0
  end

  private

  def add_users_column_safe(column_name, type, options = {})
    return if column_exists?(:users, column_name)
    add_column(:users, column_name, type, options)
  end
end
