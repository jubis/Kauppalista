class SessionsController < ApplicationController
  def login
  end

  def login_attempt
  	auth_user = User.auth( params[ :email ], params[ :password ] )
  	if auth_user
  		flash[ :notice ] = "Welcome, " + auth_user.name
  		redirect_to "/"
  	else
  		flash[ :error ] = "Login failed"
  		redirect_to "/login"
  	end
  end
end
