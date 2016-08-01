class AddTestsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :user_id, :integer
  end
end
