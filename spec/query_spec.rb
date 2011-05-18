require './spec/boot'

describe "Query" do
  it "Can retrieve an all query with empty params" do
    rs = ShopifyAPI::Product.all
    (rs.length == ShopifyAPI::Product.count).should be_true    
  end
  
    
  it "Can respect limit param when provided" do
    rs = ShopifyAPI::Product.all(:params => {:limit => 1})
    puts "limit rs: #{rs.length}"
    (rs.length == 1).should be_true
  end
  
  it "Can aggregate resultset by using :limit => false" do
    rs = ShopifyAPI::Product.all(:params => {:limit => false})
    puts "len: #{rs.length}"
    (rs.length == ShopifyAPI::Product.count).should be_true
  end
    
  
end