# This migration comes from hello (originally 1)
class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.references :user, index: true
      t.string :type

      t.string :email
      t.string :digest

      t.datetime :confirmed_at
      t.string :verifying_token_digest
      t.datetime :verifying_token_digested_at

      t.timestamps
    end
  end
end
