require './spec/boot'

describe "Query" do
  it "Can retrieve an all query" do
    rs = ShopifyAPI.all(:order, :params => {})
    (rs.length == ShopifyAPI::Order.count).should be_true    
  end
  
  it "Can retrieve an all query with no parms" do
    rs = ShopifyAPI.all(:order)
    (rs.length == ShopifyAPI::Order.count).should be_true    
  end
  
  it "Can retrieve an all query with no parms" do
    rs = ShopifyAPI.all(:order)
    (rs.length == ShopifyAPI::Order.count).should be_true    
  end
  
  it "Can retrieve a resultset with custom :limit" do
    rs = ShopifyAPI.all(:order, :params => {:limit => 1})
    puts "len: #{rs.length}"
    (rs.length == 1).should be_true    
  end
  
end