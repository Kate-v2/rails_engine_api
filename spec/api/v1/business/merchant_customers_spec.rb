require "rails_helper"
require "api_helper"

RSpec.describe "Merchant Customers" do
  include APIHelper

  before(:each) do
    min_customer
    mid_customer
    max_customer
  end


  describe 'favorite_customer' do
    it 'finds a favorite' do
      get api_v1_merchant_favorite_customer_path(@merch1)
      customer = json_data
      expect(response).to be_successful
      expect(customer.class).to eq(Hash)
      expect(customer['attributes']['id']).to eq(@cust_31.id)
    end
  end

  describe 'pending customers' do

    it 'finds all pending' do
      get api_v1_merchant_pending_customer_path(@merch1)
      customers = json_data
      customer = customers.first
      expect(response).to be_successful
      expect(customers.class).to eq(Array)
      expect(customers.count).to eq(1)
      expect(customer['attributes']['id']).to eq(@cust_11.id)
    end

  end


end


def min_customer
  @merch1 = create(:merchant)

  @item_11  = create(:item, merchant: @merch1)
  @item_12  = create(:item, merchant: @merch1)

  @cust_11 = create(:customer)

  @inv_11 = create(:invoice, merchant: @merch1, customer: @cust_11)
  @inv_item_11 = create(:invoice_item, invoice: @inv_11, item: @item_11)
  @inv_item_12 = create(:invoice_item, invoice: @inv_11, item: @item_12)
  @trans_11 = create(:transaction, invoice: @inv_11, result: 0)
  @trans_12 = create(:transaction, invoice: @inv_11, result: 0)

end


def mid_customer
  # @merch2 = create(:merchant)

  @item_21  = create(:item, merchant: @merch1)
  @item_22  = create(:item, merchant: @merch1)

  @cust_21 = create(:customer)

  @inv_21 = create(:invoice, merchant: @merch1, customer: @cust_21)
  @inv_item_21 = create(:invoice_item, invoice: @inv_21, item: @item_21)
  @inv_item_22 = create(:invoice_item, invoice: @inv_21, item: @item_22)
  @trans_21 = create(:transaction, invoice: @inv_21, result: 0)
  @trans_22 = create(:transaction, invoice: @inv_21, result: 1)

end


def max_customer
  # @merch3 = create(:merchant)

  @item_31  = create(:item, merchant: @merch1)
  @item_32  = create(:item, merchant: @merch1)

  @cust_31 = create(:customer)

  @inv_31 = create(:invoice, merchant: @merch1, customer: @cust_31)
  @inv_32 = create(:invoice, merchant: @merch1, customer: @cust_31)
  @inv_item_31 = create(:invoice_item, invoice: @inv_31, item: @item_31)
  @inv_item_32 = create(:invoice_item, invoice: @inv_31, item: @item_32)
  @trans_31 = create(:transaction, invoice: @inv_31, result: 0)
  @trans_32 = create(:transaction, invoice: @inv_31, result: 1)
  @trans_33 = create(:transaction, invoice: @inv_32, result: 1)

end
