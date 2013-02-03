class User < ActiveRecord::Base
  attr_accessible :name, :username
  has_many :items
end
