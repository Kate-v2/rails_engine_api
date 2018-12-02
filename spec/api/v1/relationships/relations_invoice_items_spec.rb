require "rails_helper"
require "api_helper"

RSpec.describe "Invoice Items Relations API" do

  include APIHelper

  before(:each) do
    @merchant = create(:merchant)
    @item1    = create(:item, merchant: @merchant)

    @customer  = create(:customer)
    @inv1      = create(:invoice, customer: @customer, merchant: @merchant)
    @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1)
  end

  describe 'Invoice' do

    before(:each) do
      get api_v1_invoice_item_invoice_path(@inv_item1)
      @invoice = json_data
    end

    it 'Sends a single invoice for the invoice item' do
      expect(response).to be_successful
      expect(@invoice.class).to eq(Hash)
      expect(@invoice['attributes']['id']).to eq(@inv1.id)

    end

    it 'Does not send an invoice unrelated to the invoice item' do
      skip("Need to setup a way to test what is not there")
    end

  end

  describe 'Item' do

    before(:each) do
      get api_v1_invoice_item_item_path(@inv_item1)
      @item = json_data
    end

    it 'Sends a single item for the invoice item' do
      expect(response).to be_successful
      expect(@item.class).to eq(Hash)
      expect(@item['attributes']['id']).to eq(@item1.id)
    end

    it 'Does not send an item unrelated to the invoice item' do
      skip("Need to setup a way to test what is not there")
    end
  end
end
