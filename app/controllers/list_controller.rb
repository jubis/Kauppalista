class ListController < ApplicationController
  before_filter :auth_user_or_redirect, :only => [ :index ]
  before_filter :auth_user_or_render_error, :only => [ :list, :form ]

  def index
  end

  def list
  	if @current_user
  		@items = @current_user.items
      respond_to do |format| 
        format.html { render :partial => 'list/list' }
        format.xml { render :xml => @items }
      end
  	else
      
  	end
  end

  def form
  	@item = Item.new
  	render :partial => 'list/form'
  end
end
