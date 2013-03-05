class Item < ActiveRecord::Base
  attr_accessible :amount, :name, :list_id

  belongs_to :list

  validates :list_id, :name, :presence => true
end
