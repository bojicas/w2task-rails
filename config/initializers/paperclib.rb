# if RAILS_ENV == "development" || RAILS_ENV == "test"
Paperclip.options[:image_magick_path] = '/opt/local/bin/' 
# else 
#  Paperclip.options[:image_magick_path] = '/usr/bin/' 
# end 
