class AddStateToApiUserRequest < ActiveRecord::Migration
  def change
    add_column :api_user_requests, :state, :string
  end
end
