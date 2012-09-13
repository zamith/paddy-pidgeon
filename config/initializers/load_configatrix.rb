file_name = "#{Rails.root}/config/config.yml"
configatrix = OpenStruct.new YAML.load_file(file_name)
Kernel.send(:define_method, :configatrix){configatrix}