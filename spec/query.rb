require './spec/boot'

describe "Query" do
  it "Can retrieve an all query with empty params" do
    rs = ShopifyAPI.all(:order, :params => {})
    (rs.length == ShopifyAPI::Order.count).should be_true    
  end
  
  it "Can retrieve an all query with no params" do
    rs = ShopifyAPI.all(:product)
    (rs.length == ShopifyAPI::Product.count).should be_true    
  end    
  
end