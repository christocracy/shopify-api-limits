require 'bundler'
Bundler.require(:default, :development)

# Load shopify c
config = YAML.load_file(File.join(File.dirname(__FILE__), "shopify_api.yml.example"))

ActiveResource::Base.site = config["site"]

shop = ShopifyAPI::Shop.current
puts "shope: #{shop}"
