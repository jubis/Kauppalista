class ListsController < ApplicationController
  before_filter :auth_user_or_redirect

  def index
  	@lists = @current_user.lists
  end

  def show
  	@list = List.find params[ :id ]
  	render :partial => 'show'
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
end
