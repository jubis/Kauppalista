class ApiUserRequestsController < ApplicationController
  before_filter :auth_user_or_redirect, :only => 'index'
  before_filter :auth_user_for_this_request, :only => [ 'accept', 'deny' ]

  def index
  	render :partial => 'api_user_requests/requests'
  end

  def auth_user_for_this_request
  	@request = ApiUserRequest.find( params[ :id ] )

  	## TODO: check authentication
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
