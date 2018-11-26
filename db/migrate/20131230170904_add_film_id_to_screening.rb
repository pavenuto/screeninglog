class AddFilmIdToScreening < ActiveRecord::Migration
  def change
    add_column :screenings, :film_id, :integer
  end
end
