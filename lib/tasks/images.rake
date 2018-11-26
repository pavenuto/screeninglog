# Assuming you had a model like this
#
# class Film
#   has_attached_file :image, :path => ":rails_root/public/system/:attachment/:id/:style/:filename"
# end


namespace :paperclip do
  desc "Recreate attachments and save them to new destination"
  task :move_attachments => :environment do

    Film.find_each do |film|
      unless film.image_file_name.blank?
        filename = Rails.root.join('public', 'system', 'images', film.id.to_s, 'original', film.image_file_name)

        if File.exists? filename
          puts "Re-saving image attachment #{film.id} - #{filename}"
          image = File.new filename
          film.image = image
          film.save
          # if there are multiple styles, you want to recreate them :
          film.image.reprocess!
          image.close
        end
      end
    end
  end
end