class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.references :user, index: true
      t.string :type

      t.string :email
      t.string :digest

      t.datetime :confirmed_at

      # WIP: combine these fields

      # EmailCredential
      t.string   :email_token_digest
      t.datetime :email_token_digested_at

      # PasswordCredential
      t.string   :reset_token_digest
      t.datetime :reset_token_digested_at

      t.timestamps
    end
  end
end
