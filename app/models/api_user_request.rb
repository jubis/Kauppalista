class ApiUserRequest < ActiveRecord::Base
  attr_accessible :api_user_id, :user_id

  belongs_to :user
  belongs_to :api_user

  validates :api_user_id, :user_id, :presence => true
  before_save :default_value

  def default_value 
  	if self.status == nil
  		self.status = 'waiting'
  	end
  end
end
