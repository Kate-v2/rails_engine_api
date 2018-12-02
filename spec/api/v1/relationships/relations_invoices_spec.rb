require "rails_helper"
require "api_helper"

RSpec.describe "Invoices Relations API" do

  include APIHelper

  before(:each) do
    store_set
    customers_set

    @inv1 = create(:invoice, customer: @customer, merchant: @merchant)

    @other_invoice  = create(:invoice, customer: @other_customer, merchant: @other_merchant)
  end

  describe "invoice invoice_items and items" do

    before(:each) do
      @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
      @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
      @inv_item_qty = 2

      @other_inv_item = create(:invoice_item, invoice: @other_invoice, item: @other_item )
    end

    describe "invoice_items" do

      before(:each) do
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

    describe "items" do

      before(:each) do
        get api_v1_invoice_has_items_path(@inv1)
        @items = json_data
        @item  = @items.first
      end

      it 'Sends a list of all items belonging to this invoice' do
        expect(response).to be_successful
        expect(@items.count).to eq(@inv_item_qty)
        item2 = @items.last
        expect(@item["attributes"]["id"]).to eq(@item1.id)
        expect(item2["attributes"]["id"]).to eq(@item2.id)
      end

      it 'Does not send items from other invoices' do
        ids = @items.map { |hash| hash["attributes"]["id"] }
        expect(ids).to     include(@item1.id)
        expect(ids).to_not include(@other_item.id)
      end

    end
  end

  describe 'transactions' do

    before(:each) do
      @trans1 = create(:transaction, invoice: @inv1 )
      @trans2 = create(:transaction, invoice: @inv1, result: 0 )
      @trans_qty = 2

      @other_transaction = create(:transaction, invoice: @other_invoice)

      get api_v1_invoice_transactions_path(@inv1)
      @transactions = json_data
      @transaction  = @transactions.first
    end

    it 'Sends a list of all transactions belonging to this invoice' do
      expect(response).to be_successful
      expect(@transactions.count).to eq(@trans_qty)
      trans2 = @transactions.last
      expect(@transaction["attributes"]["id"]).to eq(@trans1.id)
      expect(trans2["attributes"]["id"]).to       eq(@trans2.id)
    end

    it 'Does not send transactions from other invoices' do
      ids = @transactions.map { |hash| hash["attributes"]["id"] }
      expect(ids).to     include(@trans1.id)
      expect(ids).to_not include(@other_transaction.id)
    end
  end

  describe 'customer' do

    before(:each) do
      get api_v1_invoice_customer_path(@inv1)
      @cust = json_data
    end

    it "Sends the customer that invoice belongs to" do
      expect(response).to be_successful
      expect(@cust.class).to eq(Hash)
      expect(@cust['attributes']['id']).to eq(@customer.id)
    end

    it 'Does not send a customer that does not belong to invoice' do
      skip("Need to setup a way to test what is not there")
    end
  end

  describe 'merchant' do

    before(:each) do
      get api_v1_invoice_merchant_path(@inv1)
      @merch = json_data
    end

    it "Sends the merchant that invoice belongs to" do
      expect(response).to be_successful
      expect(@merch.class).to eq(Hash)
      expect(@merch['attributes']['id']).to eq(@merchant.id)
    end

    it 'Does not send a merchant that does not belong to invoice' do
      skip("Need to setup a way to test what is not there")
    end
  end


end

  # merchant
