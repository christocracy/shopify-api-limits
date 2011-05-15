require 'bundler'
Bundler.require(:default, :development)

# Load shopify config
config = YAML.load_file(File.join(File.dirname(__FILE__), "shopify_api.yml"))

ActiveResource::Base.site = config["site"]
