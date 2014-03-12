class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :upvotes, default: 0

      t.timestamps
    end
  end
end
