class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :prompt
      t.integer :answer

      t.timestamps
    end
  end
end
