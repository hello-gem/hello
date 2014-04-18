class CreateHelloUsers < ActiveRecord::Migration
  def change
    create_table :hello_users do |t|
      t.string :name
      t.string :role, default: 'user'
      t.integer :identities_count, default: 0
      t.integer :sessions_count, default: 0

      t.timestamps
    end
  end
end
