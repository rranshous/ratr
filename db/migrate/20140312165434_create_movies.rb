class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :upvotes, default: 0
      t.string :release_date

      t.timestamps
    end
  end
end
