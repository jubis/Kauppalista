class UsersController < ApplicationController
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

  def index
  	@users = User.all
  end

  def new 
  	@user = User.new
  end
end
