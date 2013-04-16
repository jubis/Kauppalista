class ApiUserRequestsController < ApplicationController
  before_filter :auth_user_or_render_error
  before_filter :auth_user_for_this_request, :only => [ 'accept', 'deny' ]

  def index
  	render :partial => 'api_user_requests/requests'
  end

  def auth_user_for_this_request
  	request = ApiUserRequest.find( params[ :id ] )
  	unless request.user_id == @current_user.id
  		render :text => 'this is not your api user request'
  	else
  		@request = request
  	end
  end

  def accept
  	@request.status = 'accepted'
  	@request.save
  	render :xml => @request
  end

  def deny
	@request.status = 'denied'
  	@request.save
  	render :xml => @request
  end
end
