require "rails_helper"
require "api_helper"


RSpec.describe 'InvoicesAPI' do
  include APIHelper

  before(:each) do
    @customer = create(:customer)
    @merchant = create(:merchant)
    # @item_qty
    # @item1, @item2 = create_list(:item, @item_qty, merchant: @merchant)

    @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
    @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
    @qty = Invoice.count
  end

  describe 'INDEX' do

    before(:each) do
      get api_v1_invoices_path
      @invoices = json_data
      @invoice  = @invoices.first
    end

    it "Sends a List of Invoices" do
      expect(response).to be_successful
      expect(@invoices.count).to eq(@qty)
      expect( json_attribute(@invoice, 'id') ).to eq(@inv1.id)
      invoice2 = @invoices.last
      expect( json_attribute(invoice2, 'id') ).to eq(@inv2.id)
    end

    describe 'Invoice Public Attributes' do
      it { json_attribute(@invoice, 'id').should     eq(@inv1.id)}
      it { json_attribute(@invoice, 'status').should eq(@inv1.status)}
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_invoice_path(@inv1)
      @invoice = json_data
    end

    it "Sends a Specific Invoice" do
      expect(response).to be_successful
      expect(@invoice.class).to eq(Hash)
      expect( json_attribute(@invoice, 'id') ).to eq(@inv1.id)
    end

    describe "Invoice Public Data" do
      it { json_attribute(@invoice, 'id').should     eq(@inv1.id)}
      it { json_attribute(@invoice, 'status').should eq(@inv1.status)}
    end
  end


end
