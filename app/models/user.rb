class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :lists
  
  validates :email, :name, :password, :presence => true
  validates :email, :uniqueness => true
  validates :password, :confirmation => true
  before_save :encrypt_password

  def encrypt_password 
  	if password.present?
  		self.salt = BCrypt::Engine.generate_salt
  		self.password = 
  				BCrypt::Engine.hash_secret( self.password, 
  											self.salt )
  	end
  end

  def self.auth( email, login_password )
  	user = User.find_by_email( email )
  	if user && user.password_match( login_password )
  		user
  	else
  		false
  	end
  end

  def password_match( login_password )
  	self.password == BCrypt::Engine.hash_secret( login_password,
  												 self.salt )
  end
end
