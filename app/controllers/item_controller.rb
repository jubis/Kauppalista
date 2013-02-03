class ItemController < ApplicationController
  def index
  end

  def create
  	@item = Item.new
  end

  def save
  	item = Item.new(params[ :item ])
  	if item.save
  	end
  	redirect_to ''
  end

  def delete
  	Item.find( params[ :id ] ).destroy
  	render :text => 'deleted'
  end

end
