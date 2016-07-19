class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :text
      t.integer :parent_question
      t.text :values

      t.timestamps
    end
  end
end
