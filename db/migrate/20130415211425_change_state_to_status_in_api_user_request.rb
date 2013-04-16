class ChangeStateToStatusInApiUserRequest < ActiveRecord::Migration
  def change
    rename_column :api_user_requests, :state, :status
  end
end
