class ItemsController < ApplicationController
  before_filter :auth_user_or_render_error

  def create
  	@item = Item.new
  end

  def save
  	item = Item.new({ :name => params[ :item ][ :name ],
                      :amount => params[ :item ][ :amount ] })
    item.user_id = @current_user.id
  	if item.save
  		render :text => "saved succesfully"
  	else
  		render :text => "saving failed " + params[ :item ].to_s
  	end
  end

  def delete
  	Item.find( params[ :id ] ).destroy
  	render :text => 'deleted'
  end

end
