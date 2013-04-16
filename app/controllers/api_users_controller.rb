class ApiUsersController < ApplicationController
  before_filter :auth_api_user_or_render_error, :only => 'request_user_access'

  def index
  	render :xml => ApiUser.all
  end

  def create
  	api_user = ApiUser.new( :name => params[ :name ], :secret => generate_secret )
  	if api_user.save
  		render :xml => api_user
  	else
  		render :xml => xml_error( 'saving failed' )
  	end
  end

  def generate_secret
  	SecureRandom.hex( 10 ) 
  end

  def request_user_access
  	user = params[ :user ]
	if User.exists?( user ) 
		if ApiUserRequest.exists?( :user_id => user, :api_user_id => @current_api_user.id )
			request = ApiUserRequest.where( :user_id => user, :api_user_id => @current_api_user.id ).first
			render :xml => { :message => 'request exists already', :request => request }.to_xml( :root => 'error' )
		else
	  		request = ApiUserRequest.new( :user_id => user, :api_user_id => @current_api_user.id )
	  		request.save
	  		render :xml => { :message => 'request created', :request => request }.to_xml( :root => 'successfull' )
	  	end
  	else 
  		render :xml => xml_error( 'bad user id' )
  	end
  end
end
