# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( bootstrap-select.min.js bootstrap-select.min.css tmpl.min.js load-image.all.min.js canvas-to-blob.min.js jquery.blueimp-gallery.min.js jquery.iframe-transport.js jquery.fileupload.js jquery.fileupload-process.js jquery.fileupload-image.js jquery.fileupload-audio.js jquery.fileupload-video.js jquery.fileupload-validate.js jquery.fileupload-ui.js)
