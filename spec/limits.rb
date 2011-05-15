
require './spec/boot'

describe "Limits" do
  it "Can fetch local limits" do
    count = ShopifyAPI.call_count :shop
    limit = ShopifyAPI.call_limit :shop
    
    (count < 300 && count > 0).should be_true
    (count < limit).should be_true
    ShopifyAPI.maxed?.should be_false
    (ShopifyAPI.available_calls > 0).should be_true
  end
  
  it "Can fetch global limits" do
    count = ShopifyAPI.call_count :global
    limit = ShopifyAPI.call_limit :global
    
    (count < 3000 && count > 0).should be_true
    (count < limit).should be_true
    ShopifyAPI.maxed?.should be_false
    (ShopifyAPI.available_calls > 0).should be_true    
  end
  
  it "Can execute up to local max" do
    until ShopifyAPI.maxed?
      ShopifyAPI::Shop.current
      puts "avail: #{ShopifyAPI.available_calls}, maxed: #{ShopifyAPI.maxed?}"
    end
  end
    
end