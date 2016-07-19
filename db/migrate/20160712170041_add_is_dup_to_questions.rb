class AddIsDupToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :isDup, :bool
  end
end
