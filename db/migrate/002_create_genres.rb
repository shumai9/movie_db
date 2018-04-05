class CreateGenres < ActiveRecord::Migration[5.1]
  def self.up
    create_table :genres do |t|
      t.string :name, null: false
    end
    create_join_table(:genres, :movies)     
  end


  def self.down
    drop_join_table(:genres, :movies)
    drop_table :genres
  end
end
