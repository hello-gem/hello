class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true
      t.references :credential, index: true
      t.string :user_agent_string
      t.string :token
      t.datetime :expires_at,      default:  DateTime.new(2000, 1,1)
      t.datetime :sudo_expires_at, default:  DateTime.new(2000, 1,1)

      t.timestamps
      t.index :token
    end
  end
end
