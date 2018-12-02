
module APIHelper

  def json_data
    JSON.parse(response.body)['data']
  end

  # def json_attribute(hash, attr_key)
  #   hash['attributes'][attr_key]
  # end

  def store_set
    @merchant = create(:merchant)
    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)

    @other_merchant = create(:merchant)
    @other_item = create(:item, merchant: @other_merchant)
  end

  def customers_set
    @customer = create(:customer)
    @other_customer = create(:customer)
  end

  




end
