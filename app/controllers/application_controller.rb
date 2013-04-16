class ApplicationController < ActionController::Base
  protect_from_forgery

  def auth_user

  	if session[ :user_id ]
  		@current_user = User.find session[ :user_id ]
      true
  	elsif auth_api_user && verify_user_access
  		@current_user = User.find params[ :user ]
      true
    else
      false
  	end
  end

  def auth_user_according_to_format
    case params[ :format ]
    when 'xml'
      auth_user_or_render_error
    else
      auth_user_or_redirect
    end
  end

  def auth_user_or_render_error
  	unless auth_user
  		respond_to do |format| 
        	format.html { render :text => "login required" }
        	format.xml { render :xml => xml_error( 'login required' ) }
      end
  	end	
  end

  def auth_user_or_redirect
  	unless auth_user
  		flash[ :error ] = "Login required"
  		redirect_to "/login"
  	end	
  end

  def auth_api_user
    api_user = ApiUser.auth( params[ :api_user_id ], params[ :secret ] )
    unless api_user
      puts 'api user auth failed'
      false
    else 
      @current_api_user = api_user
      true
    end
  end

  def auth_api_user_or_render_error
    unless auth_api_user
      render :xml => xml_error( 'api user authentication failed' )
    end
  end

  def verify_user_access
    request = @current_api_user.api_user_requests.where( :user_id => params[ :user ] ).first
    if request
      if request.status == 'accepted'
        true
      else
        #render :text => 'request not accepted'
        puts 'api user request not accepted'
        false
      end
    else
      #render :text => 'no valid request exists'
      puts 'no valid request exists'
      false
    end
  end

  def xml_error( message )
    { :message => message }.to_xml( :root => 'error' )
  end
end
