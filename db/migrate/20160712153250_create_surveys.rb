class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.integer :test_id
      t.integer :question_index

      t.timestamps
    end
  end
end
