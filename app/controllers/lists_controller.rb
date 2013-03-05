class ListsController < ApplicationController
  before_filter :auth_user_or_redirect

  def index
  	@lists = @current_user.lists
  end

  def show
  	@list = List.find params[ :id ]
  	if @list.user_id == @current_user.id
  		@items = @list.items
      
      	respond_to do |format| 
        	format.html {
        		if params[ :partial ]
        			render :partial => 'lists/list'
        		end
        	}
        	format.xml { render :xml => @items }
      	end
    else 
    	flash[ :error ] = 'You are not authorized'
    	redirect_to '/lists'
    end
  end

  def create
  	list = List.new( params[ :list ] )
  	list.user_id = @current_user.id
  	if list.save
  		flash[ :notice ] = 'succesfully create new list'
  		redirect_to '/lists/' + list.id.to_s
  	else
  		flash[ :error ] = 'creation failed'
  		render 'lists/new'
  	end
  end

  def new
  	@list = List.new
  end

  def destroy
  end

  def clean
  	for list in List.all
  		unless list.user_id
  			list.destroy
  		end
  	end 
  	redirect_to '/'
  end
end
