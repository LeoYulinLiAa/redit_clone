class User < ApplicationRecord

  include BCrypt

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true
  validates :token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  after_initialize :ensure_token

  attr_reader :password

  def self.find_by_credential(username, password)
    user = User.find_by_username(username)
    user if user&.valid_password?(password)
  end

  def password=(password)
    self.password_digest = Password.create(password)
    @password = password
  end

  def valid_password?(password)
    Password.new(password_digest).is_password?(password)
  end

  def refresh_token!
    self.token = SecureRandom.urlsafe_base64
    save!
    token
  end

  def ensure_token
    self.token ||= SecureRandom.urlsafe_base64
  end

end
