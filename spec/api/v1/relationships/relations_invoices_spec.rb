require "rails_helper"
require "api_helper"

RSpec.describe "Invocies Relations API" do
  include APIHelper

  before(:each) do
    store_set
    customers_set

    @inv1 = create(:invoice, customer: @customer, merchant: @merchant)


    @other_invoice  = create(:invoice, customer: @other_customer, merchant: @other_merchant)
  end

  describe "invoice items" do

    before(:each) do
      @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
      @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
      @inv_item_qty = 2

      @other_inv_item = create(:invoice_item, invoice: @other_invoice, item: @other_item )

      get api_v1_invoice_invoice_items_path(@inv1)
      @invoice_items = json_data
      @invoice_item  = @invoice_items.first
    end

    it 'Sends a list of all invoice items belonging to this invoice' do
      expect(response).to be_successful
      expect(@invoice_items.count).to eq(@inv_item_qty)
      invoice_item2 = @invoice_items.last
      expect(@invoice_item["attributes"]["id"]).to eq(@inv_item1.id)
      expect(invoice_item2["attributes"]["id"]).to eq(@inv_item2.id)
    end

    it 'Does not send invoice items from other invoices' do
      ids = @invoice_items.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@inv_item1.id)
      expect(ids).to_not include(@other_inv_item.id)
    end

  end

end


  # items
  # invoice_items
  # transactions
  # customer
  # merchant
