require "rails_helper"
require "api_helper"

RSpec.describe "Transactions Relations API" do
  include APIHelper

  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)

    @inv1    = create(:invoice, customer: @customer, merchant: @merchant)
    @trans1  = create(:transaction, invoice: @inv1)
    @inv_qty = 1

    @other_invoice     = create(:invoice, customer: @customer, merchant: @merchant)
    @other_transaction = create(:transaction, invoice: @other_invoice)
  end

  describe "transaction invoices" do

    before(:each) do
      get api_v1_transaction_invoice_path(@trans1)
      @invoice = json_data
    end

    it 'Sends the invoice that the transaction belongs to' do
      expect(response).to be_successful
      expect(@invoice.class).to eq(Hash)
      expect(@invoice["attributes"]["id"]).to eq(@inv1.id)
    end

    it "Does not send an invoice that belongs to another transaction" do
      skip('Need to setup a way to test what is not there')
    end
  end

end
