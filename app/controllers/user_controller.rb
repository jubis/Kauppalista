class UserController < ApplicationController
  def create
  	User.create( params[ :user ] )
  end

  def index
  	@users = User.all
  end
end
