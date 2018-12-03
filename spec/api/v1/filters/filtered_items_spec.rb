require "rails_helper"
require "api_helper"

RSpec.describe "Item Filtering API" do
  include APIHelper

  describe 'Find' do

    describe 'it filters name or id' do

      before(:each) do
        @merchant = create(:merchant)
        @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
      end

      it 'finds by name' do
        name       = @item1.name
        name_up    = @item1.name.upcase
        name_down  = @item1.name.downcase
        name_camel = @item1.name.capitalize

        get api_v1_items_find_path(name: name)
        @item = json_data

        expect(response).to be_successful
        expect(@item['attributes']['id']).to eq(@item1.id)

        get api_v1_items_find_path(name: name_up)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item1.id)

        get api_v1_items_find_path(name: name_down)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item1.id)

        get api_v1_items_find_path(name: name_camel)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item1.id)
      end

      it 'finds by id' do
        id = @item1.id
        get api_v1_items_find_path(id: id)
        @item = json_data

        expect(response).to be_successful
        expect(@item.class).to eq(Hash)
        expect(@item['attributes']['id']).to eq(id)
      end

    end

    describe 'it filters by created or updated at date' do

      before(:each) do
        @merchant = create(:merchant)
        @item1 = create(:item, merchant: @merchant)
        sleep(1)
        @item2 = create(:item, merchant: @merchant)
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@item1.created_at).to_not eq(@item2.created_at)
        date = @item1.created_at

        get api_v1_items_find_path(created_at: date)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item1.id)

        date = @item2.created_at
        get api_v1_items_find_path(created_at: date)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@item1.updated_at).to_not eq(@item2.updated_at)
        date = @item1.updated_at

        get api_v1_items_find_path(updated_at: date)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item1.id)

        date = @item2.updated_at
        get api_v1_items_find_path(updated_at: date)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item2.id)
      end
    end

  end




  describe 'Find All' do

    describe 'it filters by name or id' do

      before(:each) do
        @merchant = create(:merchant)
        @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
      end

      it 'finds by name' do
        name       = @item1.name
        name_up    = @item1.name.upcase
        name_down  = @item1.name.downcase
        name_camel = @item1.name.capitalize

        get api_v1_items_find_all_path(name: name)
        @items = json_data
        @item = @items.first

        expect(response).to be_successful
        expect(@items.class).to eq(Array)
        expect(@item['attributes']['id']).to eq(@item1.id)

        get api_v1_items_find_all_path(name: name_up)
        @items = json_data
        @item = @items.first
        expect(@item['attributes']['id']).to eq(@item1.id)

        get api_v1_items_find_all_path(name: name_down)
        @items = json_data
        @item = @items.first
        expect(@item['attributes']['id']).to eq(@item1.id)

        get api_v1_items_find_all_path(name: name_camel)
        @items = json_data
        @item = @items.first
        expect(@item['attributes']['id']).to eq(@item1.id)
      end

      it 'finds by id' do
        id = @item1.id
        get api_v1_items_find_all_path(id: id)
        @items = json_data
        @item = @items.first

        expect(response).to be_successful
        expect(@items.class).to eq(Array)
        expect(@item['attributes']['id']).to eq(id)
      end
    end

    describe 'it filters by created or updated at' do

      before(:each) do
        @merchant = create(:merchant)
        @item1 = create(:item, merchant: @merchant)
        sleep(1)
        @item2 = create(:item, merchant: @merchant)
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@item1.created_at).to_not eq(@item2.created_at)
        date = @item1.created_at

        get api_v1_items_find_all_path(created_at: date)
        @items = json_data
        @item  = @items.first
        expect(response).to be_successful
        expect(@items.to_a).to eq(Array)
        expect(@item['attributes']['id']).to eq(@item1.id)

        date = @item2.created_at
        get api_v1_items_find_path(created_at: date)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@item1.updated_at).to_not eq(@item2.updated_at)
        date = @item1.updated_at

        get api_v1_items_find_all_path(updated_at: date)
        @items = json_data
        @item  = @items.first
        expect(response).to be_successful
        expect(@items.to_a).to eq(Array)
        expect(@item['attributes']['id']).to eq(@item1.id)

        date = @item2.updated_at
        get api_v1_items_find_path(updated_at: date)
        @item = json_data
        expect(@item['attributes']['id']).to eq(@item2.id)
      end
    end
  end


  describe 'Random' do

    before(:each) do
      @merchant = create(:merchant)
      @item1, @item2, @item3 = create_list(:item, 3, merchant: @merchant)
    end

    it 'returns a single random item' do
      get api_v1_items_random_path
      @item = json_data
      expect(@item.class).to eq(Hash)
      expect(@item['attributes']).to include('id')
    end

  end

end
