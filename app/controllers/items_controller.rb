class ItemController < ApplicationController
  def index
    respond_to do |format|
      format.xml { render :xml => Item.all }
    end
  end

  def create
  	@item = Item.new
  end

  def save
  	item = Item.new(params[ :item ])
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
