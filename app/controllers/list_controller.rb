class ListController < ApplicationController
  def index
  	@items = Item.all
  	@users = User.all

  	@item = Item.new
  end
end
