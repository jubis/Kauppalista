class ListController < ApplicationController
  before_filter :load_user

  def load_user
  	@user = User.where( :username => params[ :user ] ).first
  end

  def index
  end

  def list
  	if @user
  		@items = @user.items
  		render :partial => 'list/list'
  	else
  		render :text => "invalid user"
  	end
  end

  def form
  	@item = Item.new
  	render :partial => 'list/form'
  end
end
