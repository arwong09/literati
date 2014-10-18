class User < ActiveRecord::Base
  attr_reader :password
  validates :password_digest, presence: true
  validates :session_token, :email, presence: true, uniqueness: true
  
  before_validation :ensure_session_token
  
  has_many :posts, class_name: :Post, foreign_key: :author_id
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end
  
  def password=(secret)
    if secret.present?
      @password = secret
      self.password_digest = BCrypt::Password.create(secret)
    end
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
