class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name

      t.timestamps
    end
  end
end
