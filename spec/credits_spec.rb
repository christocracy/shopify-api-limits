
require './spec/boot'

describe "Limits" do
  it "Can fetch local limits" do
    count = ShopifyAPI.credit_used :shop
    limit = ShopifyAPI.credit_limit :shop
    
    (count < limit).should be_true
    (count > 0).should be_true
    ShopifyAPI.credit_maxed?.should be_false
    (ShopifyAPI.credit_left > 0).should be_true
  end
  
  it "Can fetch global limits" do
    count = ShopifyAPI.credit_used :global
    limit = ShopifyAPI.credit_limit :global
    
    (count < 3000 && count > 0).should be_true
    (count < limit).should be_true
    ShopifyAPI.credit_maxed?.should be_false
    (ShopifyAPI.credit_left > 0).should be_true    
  end
  
  it "Can execute up to local max" do
    until ShopifyAPI.credit_maxed?
      ShopifyAPI::Shop.current
      puts "avail: #{ShopifyAPI.credit_left}, maxed: #{ShopifyAPI.credit_maxed?}"
    end
    ShopifyAPI.credit_maxed?.should be_true
    (ShopifyAPI.credit_left == 0).should be_true
  end
    
end
