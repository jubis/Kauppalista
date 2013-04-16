class ApiUser < ActiveRecord::Base
  attr_accessible :name, :secret

  has_many :api_user_requests
  has_many :users, :through => :api_user_requests

  validates :name, :secret, :presence => true

  def self.auth( id, secret )
  	if ApiUser.exists?( id )
	  	api_user = ApiUser.find( id )
	  	if api_user.secret == secret
	  		api_user
	  	else
	  		puts 'unvalid secret'
	  		false
	  	end
  	else
  		puts 'api user doesn\'t exists: ' + id.to_s
  	end

  end
end
