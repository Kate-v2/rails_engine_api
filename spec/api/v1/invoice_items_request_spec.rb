require "rails_helper"
require "api_helper"

RSpec.describe "InvoiceItemsAPI" do
  include APIHelper

  before(:each) do
    @customer = create(:customer)
    @merchant = create(:merchant)
    @item_qty = 2
    @item1, @item2 = create_list(:item, @item_qty, merchant: @merchant)

    @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
    @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
    @inv_qty = Invoice.count


    @i_item11 = create(:invoice_item, invoice: @inv1, item: @item1)
    @i_item12 = create(:invoice_item, invoice: @inv1, item: @item2)
    @i_item21 = create(:invoice_item, invoice: @inv2, item: @item1)
    @i_item22 = create(:invoice_item, invoice: @inv2, item: @item2)
    @qty = InvoiceItem.count
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_invoice_items_path
      @i_items = json_data
      @i_item  = @i_items.first
    end

    it 'Sends a List of Invocie Items' do
      expect(response).to be_successful
      expect(@i_items.count).to eq(@qty)
      item2 = @i_items[1]
      item3 = @i_items[2]
      item4 = @i_items[3]
      expect(@i_item['attributes']['id']).to eq(@i_item11.id)
      expect(item2['attributes']['id']).to   eq(@i_item12.id)
      expect(item3['attributes']['id']).to   eq(@i_item21.id)
      expect(item4['attributes']['id']).to   eq(@i_item22.id)
    end

    describe "Invoice Item Public Attributes" do
      it { @i_item['attributes']['id'].should          eq(@i_item11.id) }
      it { @i_item['attributes']['quantity'].should    eq(@i_item11.quantity) }
      it { @i_item['attributes']['unit_price'].should  eq(@i_item11.unit_price) }
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_invoice_item_path(@i_item11)
      @i_item = json_data
    end

    it 'Sends a Specific Invoice Item' do
      expect(response).to be_successful
      expect(@i_item.class).to eq(Hash)
      expect(@i_item['attributes']['id']).to eq(@i_item11.id)
    end

    describe "Invoice Item Public Attributes" do
      it { @i_item['attributes']['id'].should          eq(@i_item11.id) }
      it { @i_item['attributes']['quantity'].should    eq(@i_item11.quantity) }
      it { @i_item['attributes']['unit_price'].should  eq(@i_item11.unit_price) }
    end
  end

end
