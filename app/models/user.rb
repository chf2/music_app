class User < ActiveRecord::Base
  attr_reader :password
  validates(
    :email, 
    :password_digest, 
    :session_token, 
    :activation_token,
    presence: true
  )

  validates :password, length: { minimum: 6, allow_nil: true}

  has_many :notes, dependent: :destroy

  after_initialize :ensure_session_token, :ensure_activation_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end
  
  def ensure_activation_token
    self.activation_token ||= generate_token
  end

  def ensure_session_token
    self.session_token ||= generate_token
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end

end
