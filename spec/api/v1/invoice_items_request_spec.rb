require "rails_helper"
require "api_helper"

RSpec.describe "InvoiceItemsAPI" do

  before(:each) do
    @qty = 2
    @item1, @item2 = create_list(:invoice_item, @qty)
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_invoice_items
      @items = json_data
      @item  = @items.first['attributes']
    end

    it 'Sends a List of Invocie Items' do
      expect(response).to be_successful
      expect(@items.count).to eq(@qty)
      expect(@item['id']).to eq(@item1.id)
      item2 = @items.last['attributes']
      expect(item2['id']).to eq(@item2.id)
    end

    describe "Invoice Item Public Attributes" do
      it 'ID'          { expect(@item['id']).to          eq(@item1.id) }
      it 'Quantity'    { expect(@item['name']).to        eq(@item1.name) }
      it 'Unit Price'  { expect(@item['unit_price']).to  eq(@item1.unit_price) }
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_invoice_item_path(@item1)
      @item = json_data
    end

    it 'Sends a Specific Invoice Item' do
      expect(response).to be_successful
      expect(@item.class).to eq(Hash)
      expect(@item['attributes']['id']).to eq(@item1.id)
    end

    describe "Invoice Item Public Attributes" do
      it 'ID'          { expect(@item['attributes']['id']).to          eq(@item1.id) }
      it 'Quantity'    { expect(@item['attributes']['name']).to        eq(@item1.name) }
      it 'Unit Price'  { expect(@item['attributes']['unit_price']).to  eq(@item1.unit_price) }
    end

end
