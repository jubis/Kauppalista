class ListController < ApplicationController
  def index
  	@items
  	user = User.where( :username => params[ :user ] ).first
  	if user != nil
  		@items = user.items
  		@user_id = user.id
  	else
  		render :text => 'invalid user'
  	end

  	@item = Item.new
  end
end
