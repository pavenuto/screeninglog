class CreateDirectorsFilms < ActiveRecord::Migration
  def change
    create_table :directors_films, id: false do |t|
     t.integer :director_id, null: false
     t.integer :film_id, null: false
    end
    add_index :directors_films, [:director_id, :film_id]
  end
end
