class User < ApplicationRecord

  validates :username, :session_token, presence: true, uniqueness: true
  validates :favorite_drink, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token

  # SPIRE

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def is_password?(password)
    bcrypt_thing = BCrypt::Password.new(self.password_digest) # makes a bcrypt object
    bcrypt_thing.is_password?(password) # checks to see if password gets digested right 
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password) # makes a digest
    @password = password
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64 # random string
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
end