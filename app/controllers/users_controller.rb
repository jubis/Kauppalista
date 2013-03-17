class UsersController < ApplicationController
  before_filter :auth_user_or_redirect, :only => [ 'show' ]

  def create
  	@user = User.new( params[ :user ] )
  	if @user.save
  		flash[ :notice ] = "Sign up succesfull"
  		redirect_to "/login"
  	else
  		flash[ :notice ] = "Sign up failed"
  	end
  	render "new"
  end

  def new 
  	@user = User.new
  end

  def show
    @user = @current_user
    @lists = @current_user.lists
  end
end
