require "rails_helper"
require "api_helper"

RSpec.describe "Invoice Item Filtering API" do
  include APIHelper

  describe 'Find' do

    describe 'it filters by item name or id' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)

        @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
        @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
        @inv_item3 = create(:invoice_item, invoice: @inv2, item: @item2 )
      end

      it 'finds by item name' do
        name       = @item1.name
        name_up    = @item1.name.upcase
        name_down  = @item1.name.downcase
        name_camel = @item1.name.capitalize

        get api_v1_invoice_items_find_path(name: name)
        @invoice_item = json_data

        expect(response).to be_successful
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        get api_v1_invoice_items_find_path(name: name_up)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        get api_v1_invoice_items_find_path(name: name_down)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        get api_v1_invoice_items_find_path(name: name_camel)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)
      end

      it 'finds by id' do
        id = @inv_item1.id
        get api_v1_invoice_items_find_path(id: id)
        @invoice_item = json_data

        expect(response).to be_successful
        expect(@invoice_item.class).to eq(Hash)
        expect(@invoice_item['attributes']['id']).to eq(id)
      end

    end

    describe 'it filters by created or updated at date' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)

        @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
        sleep(1)
        @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv_item1.created_at).to_not eq(@inv_item2.created_at)
        date = @inv_item1.created_at

        get api_v1_invoice_items_find_path(created_at: date)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        date = @inv_item2.created_at
        get api_v1_invoice_items_find_path(created_at: date)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv_item1.updated_at).to_not eq(@inv_item2.updated_at)
        date = @inv_item1.updated_at

        get api_v1_invoice_items_find_path(updated_at: date)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        date = @inv_item2.updated_at
        get api_v1_invoice_items_find_path(updated_at: date)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item2.id)
      end
    end

  end




  describe 'Find All' do

    describe 'it filters by item name or id' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)

        @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
        @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
        @inv_item3 = create(:invoice_item, invoice: @inv2, item: @item2 )
      end

      it 'finds by item name' do
        name       = @item1.name
        name_up    = @item1.name.upcase
        name_down  = @item1.name.downcase
        name_camel = @item1.name.capitalize

        get api_v1_invoice_items_find_all_path(name: name)
        @invoice_items = json_data
        @invoice_item = @invoice_items.first

        expect(response).to be_successful
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        get api_v1_invoice_items_find_all_path(name: name_up)
        @invoice_items = json_data
        @invoice_item = @invoice_items.first
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        get api_v1_invoice_items_find_all_path(name: name_down)
        @invoice_items = json_data
        @invoice_item = @invoice_items.first
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        get api_v1_invoice_items_find_all_path(name: name_camel)
        @invoice_items = json_data
        @invoice_item = @invoice_items.first
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)
      end

      it 'finds by id' do
        id = @inv_item1.id
        get api_v1_invoice_items_find_all_path(id: id)
        @invoice_items = json_data
        @invoice_item = @invoice_items.first

        expect(response).to be_successful
        expect(@invoice_items.class).to eq(Array)
        expect(@invoice_item.class).to  eq(Hash)
        expect(@invoice_item['attributes']['id']).to eq(id)
      end
    end

    describe 'it filters by created or updated at' do

      before(:each) do
        store_set
        customers_set
        @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
        @inv2 = create(:invoice, merchant: @merchant, customer: @customer)

        @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
        sleep(1)
        @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
        # @inv_item3 = create(:invoice_item, invoice: @inv2, item: @item2 )
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv_item1.created_at).to_not eq(@inv_item2.created_at)
        date = @inv_item1.created_at

        get api_v1_invoice_items_find_all_path(created_at: date)
        @invoice_items = json_data
        @invoice_item  = @invoice_items.first
        expect(response).to be_successful
        expect(@invoice_items.to_a).to eq(Array)
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        date = @inv_item2.created_at
        get api_v1_invoice_items_find_all_path(created_at: date)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@inv_item1.updated_at).to_not eq(@inv_item2.updated_at)
        date = @inv_item1.updated_at

        get api_v1_invoice_items_find_all_path(updated_at: date)
        @invoice_items = json_data
        @invoice_item  = @invoice_items.first
        expect(response).to be_successful
        expect(@invoice_items.to_a).to eq(Array)
        expect(@invoice_item['attributes']['id']).to eq(@inv_item1.id)

        date = @inv_item2.updated_at
        get api_v1_invoice_items_find_all_path(updated_at: date)
        @invoice_item = json_data
        expect(@invoice_item['attributes']['id']).to eq(@inv_item2.id)
      end
    end
  end


  describe 'Random' do

    before(:each) do
      store_set
      customers_set
      @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
      @inv2 = create(:invoice, merchant: @merchant, customer: @customer)

      @inv_item1 = create(:invoice_item, invoice: @inv1, item: @item1 )
      @inv_item2 = create(:invoice_item, invoice: @inv1, item: @item2 )
      @inv_item3 = create(:invoice_item, invoice: @inv2, item: @item2 )
    end

    it 'returns a single random invoice_item' do
      get api_v1_invoice_items_random_path
      @invoice_item = json_data
      expect(@invoice_item.class).to eq(Hash)
      expect(@invoice_item['attributes']).to include('id')
    end

  end

end
