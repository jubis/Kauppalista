class ItemsController < ApplicationController
  before_filter :auth_user_or_render_error
  before_filter :list_belongs_to_current_user, :only => ( 'create', 'destroy' )

  def new
  	@item = Item.new
    @item.list_id = params[ :list_id ]
    render :partial => 'items/new'
  end

  def create
  	@item = Item.new( params[ :item ] )

  	if @valid_user && @item.save
  		render :text => 'saved succesfully'
  	else
      invalid_list_id = (!@valid_user ? 'invalid list_id ' + @item.list_id.to_s + ' ' : '')
  		render :text => 'saving failed ' +  invalid_list_id + params[ :item ].to_s
  	end
  end

  def destroy
    if @valid_user
      Item.find( params[ :id ] ).destroy
      render :text => 'destroyed'
    else
      render :text => 'not authorized user for destoying'
    end
  end

  def list_belongs_to_current_user
    for list in @current_user.lists
      if @item.list_id == list.id
        @valid_user = true
        return
      end
    end
    @valid_user = false
  end
end
