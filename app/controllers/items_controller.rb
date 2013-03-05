class ItemsController < ApplicationController
  before_filter :auth_user_or_render_error

  def new
  	@item = Item.new
    @item.list_id = params[ :list_id ]
    render :partial => 'items/new'
  end

  def create
  	@item = Item.new( params[ :item ] )

    valid_list_id = list_belongs_to_current_user
  	if valid_list_id && @item.save
  		render :text => 'saved succesfully'
  	else
      invalid_list_id = (!valid_list_id ? 'invalid list_id ' + @item.list_id.to_s + ' ' : '')
  		render :text => 'saving failed ' +  invalid_list_id + params[ :item ].to_s
  	end
  end

  def destroy
  	Item.find( params[ :id ] ).destroy
  	render :text => 'deleted'
  end

  def list_belongs_to_current_user
    for list in @current_user.lists
      if @item.list_id == list.id
        return true
      end
    end
    return false
  end
end
