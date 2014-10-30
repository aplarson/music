# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  after_initialize do
    ensure_session_token
  end

  def self.find_by_credentials(email, password)
  	@user = User.find_by_email(email)
  	if @user && @user.is_password?(password)
  		@user
  	else
  		nil
  	end
  end

  def self.generate_session_token
  	SecureRandom.urlsafe_base64
  end

  def ensure_session_token
  	self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
  	BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
  	self.session_token = SecureRandom.urlsafe_base64
  	self.save!
  end
end
