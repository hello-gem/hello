# This migration comes from hello (originally 1)
class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.references :user, index: true
      t.string :type
      t.string :email

      t.string   :email_token_digest
      t.datetime :email_token_digested_at
      t.datetime :email_confirmed_at

      t.timestamps
    end
  end
end
