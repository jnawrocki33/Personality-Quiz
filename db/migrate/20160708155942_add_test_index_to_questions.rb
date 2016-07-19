class AddTestIndexToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :test_id, :integer
  end
end
