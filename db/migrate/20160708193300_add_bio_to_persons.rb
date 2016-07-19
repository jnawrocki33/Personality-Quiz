class AddBioToPersons < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :bio, :text
  end
end
