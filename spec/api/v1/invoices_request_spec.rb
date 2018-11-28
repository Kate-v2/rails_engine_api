require "rails_helper"
require "api_helper"


RSpec.describe 'InvoicesAPI' do

  before(:each) do
    @qty = 2
    @inv1, @inv2 = create_list(:invoice, @qty)
  end

  describe 'INDEX' do

    before(:each) do
      get api_v1_invoices_path
      # @invoices = JSON.parse(response.body)['data']
      @invoices = json_data
      @invoice  = @invoices.first['attributes']
    end

    it "Sends a List of Invoices" do
      expect(response).to be_successful
      expect(@invoices.count).to eq(@qty)
      expect(@invoice['id']).to  eq(@inv1.id)
      inv2 = @invoices.last['attributes']
      expect(inv2['id']).to eq(@inv2.id)
    end

    describe 'Invoice Public Attributes' do
      it "ID"     { expect(@invoice['id']).to     eq(@inv1.id) }
      it "Status" { expect(@invoice['status']).to eq(@inv1.status) }
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_invoice_path(@inv1)
      # @invoice = JSON.parse(response.body)['data']
      @invoice = json_data
    end

    it "Sends a Specific Invoice" do
      expect(response).to be_successful
      expect(@invoice.class).to eq(Hash)
      expect(@invoice['attributes']['id']).to eq(@inv1.id)
    end

    describe "Invoice Public Data" do
      it "ID"     { expect(@invoice['attributes']['id']).to     eq(@inv1.id) }
      it "Status" { expect(@invoice['attributes']['status']).to eq(@inv1.status) }
    end
  end


end
