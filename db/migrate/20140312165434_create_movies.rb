class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :upvotes
      t.text :description

      t.timestamps
    end
  end
end
