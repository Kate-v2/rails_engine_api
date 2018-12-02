require "rails_helper"
require "api_helper"

RSpec.describe "Items Relations API" do

  include APIHelper

  before(:each) do
    store_set
    customers_set

    @inv1 = create(:invoice, customer: @customer, merchant: @merchant)
    @inv2 = create(:invoice, customer: @other_customer, merchant: @merchant)

    @inv_item_11 = create(:invoice_item, invoice: @inv1, item: @item1 )
    @inv_item_21 = create(:invoice_item, invoice: @inv2, item: @item1 )
    @inv_item_qty = 2

    # @other_invoice = create(:invoice, customer: @other_customer, merchant: @other_merchant)
    @other_invoice_item = create(:invoice_item, invoice: @inv1, item: @item2)
  end

  describe 'invoice_items' do

    before(:each) do
      get api_v1_item_invoice_items_path(@item1)
      @invoice_items = json_data
      @invoice_item  = @invoice_items.first
    end

    it 'Sends a list of all invoice items for an item' do
      expect(response).to be_successful
      expect(@invoice_items.count).to eq(@inv_item_qty)
      inv_item2 = @invoice_items.last
      expect(@invoice_item['attributes']['id']).to eq(@inv_item_11.id)
      expect(inv_item2['attributes']['id']).to     eq(@inv_item_21.id)
    end

    it 'Does not send an invoice item unrelated to the item' do
      ids = @invoice_items.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@inv_item_11.id)
      expect(ids).to_not include(@other_invoice_item.id)
    end
  end

  describe 'merchant' do

    before(:each) do
      get api_v1_item_merchant_path(@item1)
      @merch = json_data
    end

    it 'Sends a single merchant related to the item' do
      expect(response).to be_successful
      expect(@merch.class).to eq(Hash)
      expect(@merch['attributes']['id']).to eq(@merchant.id)
    end

    it 'Does not send a merchant unrelated to the item' do
      skip('Need to setup a way to test what is not there')
    end
  end

end
