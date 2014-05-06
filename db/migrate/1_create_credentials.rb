class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.references :user, index: true
      t.string :strategy
      t.string :email
      t.string :username
      t.string :password_digest
      t.integer :sessions_count, default: 0

      t.string   :password_token_digest
      t.datetime :password_token_digested_at
      
      t.string   :email_token_digest
      t.datetime :email_confirmed_at

      t.timestamps
    end
  end
end
