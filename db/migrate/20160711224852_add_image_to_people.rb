class AddImageToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :image_path, :string
  end
end
