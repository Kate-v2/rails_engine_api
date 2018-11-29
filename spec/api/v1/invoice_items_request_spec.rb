require "rails_helper"
require "api_helper"

RSpec.describe "InvoiceItemsAPI" do

  before(:each) do
    @customer = create(:customer)
    @merchant = create(:merchant)
    @item_qty
    @item1, @item2 = create_list(:item, @item_qty, merchant: @merchant)

    @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
    @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
    @inv_qty = Invoice.count



    @qty = 2
    @i_item1, @i_item2 = create_list(:invoice_item, @qty)
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_invoice_items
      @items = json_data
      @item  = @items.first
    end

    it 'Sends a List of Invocie Items' do
      expect(response).to be_successful
      expect(@items.count).to eq(@qty)
      expect(@item['attributes']['id']).to eq(@i_item1.id)
      item2 = @items.last
      expect(item2['attributes']['id']).to eq(@i_item2.id)
    end

    describe "Invoice Item Public Attributes" do
      it { @item['attributes']['id'].should          eq(@i_item1.id) }
      it { @item['attributes']['name'].should        eq(@i_item1.name) }
      it { @item['attributes']['unit_price'].should  eq(@i_item1.unit_price) }
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_invoice_item_path(@i_item1)
      @item = json_data
    end

    it 'Sends a Specific Invoice Item' do
      expect(response).to be_successful
      expect(@item.class).to eq(Hash)
      expect(@item['attributes']['id']).to eq(@i_item1.id)
    end

    describe "Invoice Item Public Attributes" do
      it { @item['attributes']['id'].should          eq(@item1.id) }
      it { @item['attributes']['name'].should        eq(@item1.name) }
      it { @item['attributes']['unit_price'].should  eq(@item1.unit_price) }
    end
  end
end
