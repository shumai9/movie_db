class AddMoviesTable < ActiveRecord::Migration[5.1]
  def self.up
    create_table :movies do |t|
      t.string :title, null: false
      t.text :description
      t.integer :year
      t.integer :runtime
      t.float :rating
      t.integer :votes
      t.integer :revenue
      t.integer :metascore
    end
  end

  def self.down
    drop_table :movies
  end
end
