class CreateScreenings < ActiveRecord::Migration
  def change
    create_table :screenings do |t|
      t.datetime :date
      t.integer :rating

      t.timestamps
    end
  end
end
