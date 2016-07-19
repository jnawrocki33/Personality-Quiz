class AddScoreAndValuesIndexToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :score, :integer
    add_column :people, :values_index, :integer
  end
end
