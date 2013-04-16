class CreateApiUserRequests < ActiveRecord::Migration
  def change
    create_table :api_user_requests do |t|
      t.integer :user_id
      t.integer :api_user_id

      t.timestamps
    end
  end
end
