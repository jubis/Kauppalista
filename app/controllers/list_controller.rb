class ListController < ApplicationController
  def index
  	@items
  	user = User.where( :username => params[ :user ] ).first
  	if user != nil
  		@items = user.items
  		@user = user
  	else
  		render :text => 'invalid user'
  	end

  	@item = Item.new
  end

  def list
  	@items
  	user = User.where( :username => params[ :user ] ).first
  	if user != nil
  		@items = user.items
  		@user = user
  		render :partial => 'list/list'
  	else
  		render :text => 'invalid user'
  	end
  end

  def form
  	
  end
end
