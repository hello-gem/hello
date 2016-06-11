class Oauth2Controller < ApplicationController
  dont_kick_people
  sudo_mode(if: :signed_in?)

  # protect_from_forgery :except => [:facebook]

  def index
  end

  def facebook
    business = FacebookBusiness.new(current_user, hash[:uid], info[:email])

    case business.magic
    when :sign_in
      sign_in!(business.user, 24.hours, 10.minutes)
      render_created

    when :sign_up
      business.sign_up!(hash)
      sign_in!(business.user, 24.hours, 10.minutes)
      render_created

    when :linked, :nothing
      # nothing to do
      render_created

    when :uid_found
      # wip
      render_errors(business.errors)

    when :email_found
      # wip
      render_errors(business.errors)

    end
  end

  private

  def render_created
    render json: {}, status: :created
  end

  def render_errors(errors)
    render json: errors, status: :unprocessable_entity
  end

  def hash
    request.env['omniauth.auth']
  end

  def info
    hash[:info]
  end

  def failure
  end

  private

  class FacebookBusiness < Hello::Business::Base
    attr_reader :user, :uid, :email, :status

    def initialize(user, uid, email)
      @user, @uid, @email = user, uid, email
    end

    def magic
      if user.present?
        magic_signed_in
      else
        magic_signed_out
      end
    end

    def sign_up!(hash)
      info = hash[:info]

      # USER

      @user = u = User.new  name:      info[:name],
                            locale:    I18n.locale.to_s,
                            time_zone: Time.zone.name,
                            email:     email,
                            username:  SecureRandom.uuid[0..30]
      p = u.password_credentials.build.set_generated_password
      u.save!

      # CREDENTIALS

      f = u.facebook_credentials.build(uid: uid, email: email)
      # u.save!
      f.save!
    # rescue ActiveRecord::RecordInvalid
    #   puts f.errors.messages
    #   puts p.errors.messages
    #   raise
    end

    def facebook_credential
      @facebook_credential ||= FacebookCredential.find_by(uid: uid)
    end

    private

    def magic_signed_in
      if facebook_credential
        if is_linked_to_my_user?
          @status = :nothing
          return true
        else
          errors[:base] << "This facebook has already been linked to another of our users."
          @status = :uid_found
          return false
        end
      else
        link_to_user!
        @status = :linked
        return true
      end
    end

    def magic_signed_out
      if facebook_credential
        @status = :sign_in
        return true
      else
        if email_found?
          errors[:base] << "You have already registered with us using <shit>. Please sign in with <shit>, then link your account."
          @status = :email_found
          return false
        else
          @status = :sign_up
          return true
        end
      end
    end

    def is_linked_to_my_user?
      facebook_credential.user == user
    end

    def email_found?
      Credential.where(email: email).exists?
    end

    def link_to_user!
      @facebook_credential = user.facebook_credentials.create!(uid: uid, email: email)
    end

  end
end




# 1. ja_estou_logado (sudo_mode!):
#   1.1. facebook_ja_cadastrado_no_BD?:
#     1.1.1. comigo?:
#       1 sucesso! nada!
#     1.1.2. nao:
#       fracasso! "este facebook ja foi associado a outro usuario"
#   1.2. nao:
#     2 sucesso! associar!
# 2. nao_estou_logado:
#   2.1. facebook_ja_cadastrado_no_BD?:
#     3 sucesso! login!
#   2.2. nao:
#     2.2.1. email_ja_cadastrado_no_BD?:
#       fracasso! demontrar_formas_que_essa_pessoa_pode_se_logar
#     2.2.2. nao:
#       4 sucesso! cadastrar!











# {
#   :provider => 'facebook',
#   :uid => '1234567',
#   :info => {
#     :email => 'joe@bloggs.com',
#     :name => 'Joe Bloggs',
#     :first_name => 'Joe',
#     :last_name => 'Bloggs',
#     :image => 'http://graph.facebook.com/1234567/picture?type=square',
#     :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
#     :location => 'Palo Alto, California',
#     :verified => true
#   },
#   :credentials => {
#     :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
#     :expires_at => 1321747205, # when the access token expires (it always will)
#     :expires => true # this will always be true
#   },
#   :extra => {
#     :raw_info => {
#       :id => '1234567',
#       :name => 'Joe Bloggs',
#       :first_name => 'Joe',
#       :last_name => 'Bloggs',
#       :link => 'http://www.facebook.com/jbloggs',
#       :username => 'jbloggs',
#       :location => { :id => '123456789', :name => 'Palo Alto, California' },
#       :gender => 'male',
#       :email => 'joe@bloggs.com',
#       :timezone => -8,
#       :locale => 'en_US',
#       :verified => true,
#       :updated_time => '2011-11-11T06:21:03+0000'
#     }
#   }
# }


