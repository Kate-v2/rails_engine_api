require 'rails_helper'
require "api_helper"

RSpec.describe "ItemsAPI" do
  include APIHelper

  before(:each) do
    @qty = 2
    @merchant = create(:merchant)
    @item1, @item2 = create_list(:item, @qty, merchant: @merchant)
  end

  describe 'INDEX' do

    before(:each) do
      get api_v1_items_path
      @items = json_data
      @item  = @items.first
    end

    it 'Sends a List of Items' do
      expect(response).to be_successful
      expect(@items.count).to eq(@qty)
      item2 = @items.last
      expect(@item['attributes']['id']).to eq(@item1.id)
      expect(item2['attributes']['id']).to eq(@item2.id)
    end

    describe "Item Public Attributes" do
      it { @item['attributes']['id'].should          eq(@item1.id)}
      it { @item['attributes']['name'].should        eq(@item1.name)}
      it { @item['attributes']['description'].should eq(@item1.description)}
      it { @item['attributes']['unit_price'].should  eq(@item1.price)}
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_item_path(@item1)
      @item = json_data
    end

    it 'Sends a Specific Item' do
      expect(response).to be_successful
      expect(@item.class).to eq(Hash)
      expect(@item['attributes']['id']).to eq(@item1.id)
    end

    describe 'Item Public Attributes' do
      it { @item['attributes']['id'].should          eq(@item1.id)}
      it { @item['attributes']['name'].should        eq(@item1.name)}
      it { @item['attributes']['description'].should eq(@item1.description)}
      it { @item['attributes']['unit_price'].should  eq(@item1.price)}
    end
  end

end
