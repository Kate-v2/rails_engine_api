require "rails_helper"
require "api_helper"

RSpec.describe "MerchantsAPI" do
  include APIHelper

  before(:each) do
    min_merchant
    mid_merchant
    max_merchant
  end

  describe 'returns total revenue for a single merchant' do

    it 'revenue' do
      get api_v1_merchant_revenue_path(@merch1)
      revenue = json_data
      rev = (@revenue1.to_f / 100).round(2)
      expect(response).to be_successful
      expect(revenue.class).to eq(Hash)
      expect(revenue['attributes']['revenue']).to eq(rev)
    end
  end

  describe 'returns total revenue for all merchants' do

    it 'total revenue' do
      get api_v1_merchants_revenue_path
      @revenue = json_data
      expect(response).to be_successful
      rev = ((@revenue1 + @revenue2 + @revenue3).to_f / 100).round(2)
      expect(@revenue['attributes']['revenue']).to eq(rev)
    end

  end


  describe 'ranks merchants by total revenue' do

    it 'top merchant' do
      get api_v1_merchants_most_revenue_path
      @merchants = json_data
      @merchant = @merchants.first

      expect(response).to be_successful
      expect(@merchants.class).to eq(Array)
      expect(@merchants.count).to eq(1)
      expect(@merchant.class).to eq(Hash)
      expect(@merchant['attributes']['id']).to eq(@merch3.id)
    end

    it 'top two merchants' do
      get api_v1_merchants_most_revenue_path(quantity: 2)
      @merchants = json_data
      @merchant1 = @merchants.first
      @merchant2 = @merchants.last

      expect(response).to be_successful
      expect(@merchants.class).to eq(Array)
      expect(@merchants.count).to eq(2)
      expect(@merchant1.class).to eq(Hash)
      expect(@merchant1).to_not eq(@merchant2)
      expect(@merchant1['attributes']['id']).to eq(@merch3.id)
      expect(@merchant2['attributes']['id']).to eq(@merch2.id)
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
