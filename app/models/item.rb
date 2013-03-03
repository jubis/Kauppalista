class Item < ActiveRecord::Base
  attr_accessible :amount, :name
  belongs_to :user

  validates :user_id, :name, :presence => true
end
