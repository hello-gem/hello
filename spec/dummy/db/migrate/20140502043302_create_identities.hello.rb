# This migration comes from hello (originally 1)
class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true
      t.string :strategy
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :token_digest
      t.datetime :token_digested_at
      t.integer :sessions_count, default: 0

      t.timestamps
    end
  end
end
