require "rails_helper"
require "api_helper"

RSpec.describe "Merchant Relations API" do
  include APIHelper

  before(:each) do
    @merchant = create(:merchant)
    @item_qty = 2
    @item1, @item2 = create_list(:item, @item_qty, merchant: @merchant)

    @other_merchant = create(:merchant)
    @other_item = create(:item, merchant: @other_merchant)
  end


  describe "merchant items" do

    before(:each) do
      get api_v1_merchant_items_path(@merchant)
      @items = json_data
      @item  = @items.first
    end

    it 'Sends a list of all items for that merchant' do
      expect(response).to be_successful
      expect(@items.count).to eq(@item_qty)
      item2 = @items.last
      expect(@item["attributes"]["id"]).to eq(@item1.id)
      expect(item2["attributes"]["id"]).to eq(@item2.id)
    end

    it 'Does not send items unrelated to this merchant' do
      ids = @items.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@item1.id)
      expect(ids).to_not include(@other_item.id)
    end

  end

  describe "merchant invoices" do

    before(:each) do
      @c_qty = 2
      @customer1, @customer2 = create_list(:customer, @c_qty)
      @inv1 = create(:invoice, merchant: @merchant, customer: @customer1 )
      @inv2 = create(:invoice, merchant: @merchant, customer: @customer2 )
      @inv_qty = Invoice.count

      @other_inv = create(:invoice, merchant: @other_merchant, customer: @customer1)

      get api_v1_merchant_invoices_path(@merchant)

      @invoices = json_data
      @invoice = @invoices.first
    end

    it 'sends a list of all invoices for that merchant' do
      expect(response).to be_successful
      expect(@invoices.count).to eq(@inv_qty)
      item2 = @invoices.last
      expect(@invoice["attributes"]["id"]).to eq(@inv1.id)
      expect(item2["attributes"]["id"]).to    eq(@inv2.id)
    end 

    it 'Does not send invoices unrelated to this merchant' do
      ids = @invoices.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@inv1.id)
      expect(ids).to_not include(@other_inv.id)
    end
  end


end
