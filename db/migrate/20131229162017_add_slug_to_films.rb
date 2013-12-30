class AddSlugToFilms < ActiveRecord::Migration
  def change
    add_column :films, :slug, :string
  end
end
