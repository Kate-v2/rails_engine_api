require "rails_helper"
require "api_helper"

RSpec.describe "Merchant by Top Sold Items" do
  include APIHelper

  before(:each) do
    min_merchant
    mid_merchant
    max_merchant
  end

  describe 'merchant with most sold items' do
    it 'merchant' do
      get api_v1_merchants_most_items_path
      merchant = json_data
      expect(response).to be_successful
      expect(merchant.class).to eq(Hash)
      expect(merchant['attributes']['id']).to eq(@merch3.id)
    end

  end


end



def min_merchant
  @merch1 = create(:merchant)

  price = 100
  quantity = 1

  @item_11  = create(:item, merchant: @merch1, unit_price: price)
  @item_12  = create(:item, merchant: @merch1, unit_price: price)

  @cust_11 = create(:customer)

  @inv_11 = create(:invoice, merchant: @merch1, customer: @cust_11)
  @inv_item_11 = create(:invoice_item, invoice: @inv_11, item: @item_11, unit_price: price, quantity: quantity)
  @inv_item_12 = create(:invoice_item, invoice: @inv_11, item: @item_12, unit_price: price, quantity: quantity)
  @trans_11 = create(:transaction, invoice: @inv_11, result: 0)
  @trans_12 = create(:transaction, invoice: @inv_11, result: 1)

  @revenue1 = (100 * 1) * 2
end


def mid_merchant
  @merch2 = create(:merchant)

  price = 200
  quantity = 2

  @item_21  = create(:item, merchant: @merch2, unit_price: price)
  @item_22  = create(:item, merchant: @merch2, unit_price: price)

  @cust_21 = create(:customer)

  @inv_21 = create(:invoice, merchant: @merch2, customer: @cust_21)
  @inv_item_21 = create(:invoice_item, invoice: @inv_21, item: @item_21, unit_price: price, quantity: quantity)
  @inv_item_22 = create(:invoice_item, invoice: @inv_21, item: @item_22, unit_price: price, quantity: quantity)
  @trans_21 = create(:transaction, invoice: @inv_21, result: 0)
  @trans_22 = create(:transaction, invoice: @inv_21, result: 1)

  @revenue2 = (200 * 2) * 2
end


def max_merchant
  @merch3 = create(:merchant)

  price = 300
  quantity = 3

  @item_31  = create(:item, merchant: @merch3, unit_price: price)
  @item_32  = create(:item, merchant: @merch3, unit_price: price)

  @cust_31 = create(:customer)

  @inv_31 = create(:invoice, merchant: @merch3, customer: @cust_31)
  @inv_item_31 = create(:invoice_item, invoice: @inv_31, item: @item_31, unit_price: price, quantity: quantity)
  @inv_item_32 = create(:invoice_item, invoice: @inv_31, item: @item_32, unit_price: price, quantity: quantity)
  @trans_31 = create(:transaction, invoice: @inv_31, result: 0)
  @trans_32 = create(:transaction, invoice: @inv_31, result: 1)

  @revenue3 = (300 * 3) * 2
end
