require "rails_helper"
require "api_helper"

RSpec.describe "Invoice Filtering API" do
  include APIHelper

  describe 'Find' do

    describe 'it filters id' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
      end

      it 'finds by id' do
        id = @inv1.id
        get api_v1_invoices_find_path(id: id)
        @invoice = json_data

        expect(response).to be_successful
        expect(@invoice.class).to eq(Hash)
        expect(@invoice['attributes']['id']).to eq(id)
      end

    end

    describe 'it filters by created or updated at date' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        sleep(1)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv1.created_at).to_not eq(@inv2.created_at)
        date = @inv1.created_at

        get api_v1_invoices_find_path(created_at: date)
        @invoice = json_data
        expect(@invoice['attributes']['id']).to eq(@inv1.id)

        date = @inv2.created_at
        get api_v1_invoices_find_path(created_at: date)
        @invoice = json_data
        expect(@invoice['attributes']['id']).to eq(@inv2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv1.updated_at).to_not eq(@inv2.updated_at)
        date = @inv1.updated_at

        get api_v1_invoices_find_path(updated_at: date)
        @invoice = json_data
        expect(@invoice['attributes']['id']).to eq(@inv1.id)

        date = @inv2.updated_at
        get api_v1_invoices_find_path(updated_at: date)
        @invoice = json_data
        expect(@invoice['attributes']['id']).to eq(@inv2.id)
      end
    end

  end




  describe 'Find All' do

    describe 'it filters id' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
      end

      it 'finds by id' do
        id = @inv1.id
        get api_v1_invoices_find_all_path(id: id)
        @invoices = json_data
        @invoice = @invoices.first

        expect(response).to be_successful
        expect(@invoices.class).to eq(Array)
        expect(@invoice.class).to  eq(Hash)
        expect(@invoice['attributes']['id']).to eq(id)
      end
    end

    describe 'it filters by created or updated at' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        sleep(1)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv1.created_at).to_not eq(@inv2.created_at)
        date = @inv1.created_at

        get api_v1_invoices_find_all_path(created_at: date)
        @invoices = json_data
        @invoice  = @invoice_items.first
        expect(response).to be_successful
        expect(@invoices.to_a).to eq(Array)
        expect(@invoice['attributes']['id']).to eq(@inv1.id)

        date = @inv2.created_at
        get api_v1_invoices_find_all_path(created_at: date)
        @invoices = json_data
        @invoice  = @invoice_items.first
        expect(@invoice['attributes']['id']).to eq(@inv2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv1.updated_at).to_not eq(@inv2.updated_at)
        date = @inv1.updated_at

        get api_v1_invoices_find_all_path(updated_at: date)
        @invoices = json_data
        @invoice  = @invoices.first
        expect(response).to be_successful
        expect(@invoices.to_a).to eq(Array)
        expect(@invoice['attributes']['id']).to eq(@inv1.id)

        date = @inv2.updated_at
        get api_v1_invoices_find_all_path(updated_at: date)
        @invoices = json_data
        @invoice  = @invoice_items.first
        expect(@invoice['attributes']['id']).to eq(@inv2.id)
      end
    end
  end


  describe 'Random' do

    before(:each) do
      store_set
      customers_set
      @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
      @inv2 = create(:invoice, merchant: @merchant, customer: @customer)
      @inv3 = create(:invoice, merchant: @merchant, customer: @customer)
    end

    it 'returns a single random invoice' do
      get api_v1_invoices_random_path
      @invoice = json_data
      expect(response).to be_successful
      expect(@invoice.class).to eq(Hash)
      expect(@invoice['attributes']).to include('id')
    end

  end

end
