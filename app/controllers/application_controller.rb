class ApplicationController < ActionController::Base
  protect_from_forgery

  def auth_user
  	unless session[ :user_id ]
  		flash[ :error ] = "Login required"
  		false
  	else
  		@current_user = User.find session[ :user_id ]
  		true
  	end	
  end

  def auth_user_or_render_error
  	unless auth_user
  		respond_to do |format| 
        	format.html { render :text => "login required" }
        	format.xml { render :xml => "<error>login required</error>" }
      	end
  	end	
  end

  def auth_user_or_redirect
  	unless auth_user
  		redirect_to "/login"
  	end	
  end
end
