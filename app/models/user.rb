class User < ActiveRecord::Base
  attr_accessible :name, :username
  has_many :items
  validates :username, :name, :presence => true
  validates :username, :uniqueness => true
end
