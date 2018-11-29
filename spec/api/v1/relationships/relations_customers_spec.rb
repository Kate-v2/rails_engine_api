require "rails_helper"
require "api_helper"

RSpec.describe "Customer Relations API" do
  include APIHelper

  before(:each) do
    store_set
    customers_set

    @inv1 = create(:invoice, customer: @customer, merchant: @merchant)
    @inv2 = create(:invoice, customer: @customer, merchant: @other_merchant)
    @inv_qty = 2

    @other_inv = create(:invoice, customer: @other_customer, merchant:@merchant)
  end

  describe 'customer invoices' do

    before(:each) do
      get api_v1_customer_invoices_path(@customer)
      @invoices = json_data
      @invoice  = @invoices.first
    end

    it 'Sends a list of all invoices for this customer' do
      expect(response).to be_successful
      expect(@invoices.count).to eq(@inv_qty)
      inv2 = @invoices.last
      expect(@invoice['attributes']['id']).to eq(@inv1.id)
      expect(inv2['attributes']['id']).to     eq(@inv2.id)
    end

    it 'Does not send invoices unrelated to this customer' do
      ids = @invoices.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@inv1.id)
      expect(ids).to_not include(@other_inv.id)
    end
  end



  describe 'customer transactions' do

    before(:each) do
      @trans_qty = 2
      @trans1 = create(:transaction, invoice: @inv1)
      @trans2 = create(:transaction, invoice: @inv2)

      @other_trans = create(:transaction, invoice: @other_inv)

      get api_v1_customer_transactions_path(@customer)

      @transactions = json_data
      @transaction  = @transactions.first
    end

    it 'sends a list of all transactions for that customer' do
      expect(response).to be_successful
      expect(@transactions.count).to eq(@trans_qty)
      trans2 = @transactions.last
      expect(@transaction["attributes"]["id"]).to eq(@trans1.id)
      expect(trans2["attributes"]["id"]).to       eq(@trans2.id)
    end

    it 'Does not send transactions unrelated to this customer' do
      ids = @transactions.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@trans1.id)
      expect(ids).to_not include(@other_trans.id)
    end

  end


end
