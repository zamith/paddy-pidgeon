# Require any additional compass plugins here.
project_type = :rails

line_comments = false
output_style = :compressed

if Rails.env.production?
  css_dir = "tmp/stylesheets/compiled"
else
  css_dir = "public/stylesheets/compiled"
end
