# Require any additional compass plugins here.
require 'bootstrap-sass'

# HTTP paths
http_path             = '/'
http_stylesheets_path = '/css'
http_images_path      = '/css/images'
http_javascripts_path = '/js'

# File system locations
css_dir         = File.join('public', 'css')
sass_dir        = 'sass'
images_dir      = File.join('public', 'css', 'images')
javascripts_dir = File.join('public', 'js')

# Syntax preference
preferred_syntax = :scss

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = true

output_style = :compressed