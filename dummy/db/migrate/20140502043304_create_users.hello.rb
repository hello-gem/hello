# This migration comes from hello (originally 3)
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :city

      t.string :role, default: 'onboarding'

      t.string :locale
      t.string :time_zone
      t.string :username

      t.integer :credentials_count, default: 0
      t.integer :accesses_count, default: 0

      t.timestamps
    end
  end
end
