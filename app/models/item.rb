class Item < ActiveRecord::Base
  attr_accessible :amount, :name
  
  belongs_to :list

  validates :list_id, :name, :presence => true
end
