class CreateApiUsers < ActiveRecord::Migration
  def change
    create_table :api_users do |t|
      t.string :name
      t.string :id
      t.string :secret

      t.timestamps
    end
  end
end
