class AddCategoryToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :category, :string
  end
end
