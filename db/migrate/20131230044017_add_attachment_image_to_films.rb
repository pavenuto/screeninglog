class AddAttachmentImageToFilms < ActiveRecord::Migration
  def self.up
    change_table :films do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :films, :image
  end
end
