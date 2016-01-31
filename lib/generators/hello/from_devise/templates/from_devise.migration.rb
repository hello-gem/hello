# customize this migration if you need, PRs accepted
class FromDevise < ActiveRecord::Migration
  def up
    from_users_to_credentials
    remove_devise_columns
  end

  def down
    fail "you can't roll this back, use a backup"
  end

  private

  def from_users_to_credentials
    puts "before Credential.count (#{Credential.count.to_s.red})"
    User.find_each do |user|
      puts "starting User ##{user.id} #{user.email}"
      username = extract_username(user)
      credential_fields = { email: user.email, username: username, password: Hello.configuration.simple_encryptor.single }
      user.email_credentials.create!(credential_fields)
    end
    puts "after Credential.count (#{Credential.count.to_s.green})"
  end

  def extract_username(user)
    username = user.try(:username).to_s
    username = username.gsub('.', '_dot_')
  end

  def remove_devise_columns
    columns = [:username, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at]
    columns.each { |column_name| remove_users_column_safe(column_name) }
  end

  def remove_users_column_safe(column_name)
    return unless column_exists?(:users, column_name)
    remove_column(:users, column_name)
  end
end
