class ListsController < ApplicationController
  before_filter :auth_user_or_redirect
  before_filter :auth_user_for_this_list, :only => [ 'show', 'destroy' ]

  def auth_user_for_this_list
  	list = List.find params[ :id ]

  	unless list.user_id == @current_user.id
  		respond_to do |format|
  			format.html {
  				flash[ :error ] = 'Trying to access list without authorization'
    			redirect_to '/lists'
    		}
    		format.xml { render :text => '<error>unauthorized access to list</error>' }
    	end
    else
    	@list = list
    end

  end

  def index
  	@lists = @current_user.lists
  end

  def show
	@items = @list.items
  
  	respond_to do |format| 
    	format.html {
    		if params[ :partial ]
    			render :partial => 'lists/list'
    		end
    	}
    	format.xml { render :xml => @items }
  	end
  end

  def create
  	list = List.new( params[ :list ] )
  	list.user_id = @current_user.id
  	if list.save
  		flash[ :notice ] = 'Succesfully create new list'
  		redirect_to '/lists/' + list.id.to_s
  	else
  		flash[ :error ] = 'Creation failed'
  		render 'lists/new'
  	end
  end

  def new
  	@list = List.new
  end

  def destroy
  	@list.destroy
  	redirect_to lists_path
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
