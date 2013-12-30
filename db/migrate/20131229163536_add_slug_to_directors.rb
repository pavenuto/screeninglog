class AddSlugToDirectors < ActiveRecord::Migration
  def change
    add_column :directors, :slug, :string
  end
end
