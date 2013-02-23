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
      respond_to do |format| 
        format.html { render :partial => 'list/list' }
        format.xml { render :xml => @items }
      end
  	else
  		render :text => "invalid user"
  	end
  end

  def form
  	@item = Item.new
  	render :partial => 'list/form'
  end
end
