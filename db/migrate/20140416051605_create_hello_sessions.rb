class CreateHelloSessions < ActiveRecord::Migration
  def change
    create_table :hello_sessions do |t|
      t.references :user, index: true
      t.references :identity, index: true
      t.string :ua

      t.timestamps
    end
  end
end
