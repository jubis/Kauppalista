class ItemsController < ApplicationController
  before_filter :auth_user_or_render_error

  def new
  	@item = Item.new
    @item.list_id = params[ :list_id ]
    render :partial => 'items/new'
  end

  def create
  	item = Item.new( params[ :item ] )

  	if list_belongs_to_current_user( item ) && item.save
  		render :text => 'saved succesfully'
  	else
      invalid_list_id = (!@valid_user ? 'invalid list_id ' + item.list_id.to_s + ' ' : '')
  		render :text => 'saving failed ' +  invalid_list_id + params[ :item ].to_s
  	end
  end

  def destroy
    unless Item.exists?( params[ :id ] )
      render :text => 'invalid user id'
      return
    end
    item = Item.find( params[ :id ] )
    if list_belongs_to_current_user( item )
      item.destroy
      render :text => 'destroyed'
    else
      render :text => 'not authorized user for destoying'
    end
  end

  def list_belongs_to_current_user( item )
    for list in @current_user.lists
      if item.list_id == list.id
        @valid_user = true
        return true
      end
    end
    @valid_user = false
    return false
  end
end
