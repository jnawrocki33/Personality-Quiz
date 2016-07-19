class AddClonerIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :cloner_id, :integer
  end
end
