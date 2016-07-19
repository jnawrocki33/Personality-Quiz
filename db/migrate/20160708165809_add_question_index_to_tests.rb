class AddQuestionIndexToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :question_index, :integer
  end
end
