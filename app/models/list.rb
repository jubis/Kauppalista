class List < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :items

  validates :name, :user_id, :presence => true
end
