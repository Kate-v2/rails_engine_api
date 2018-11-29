require "rails_helper"
require "api_helper"

RSpec.describe "MerchantsAPI" do
  include APIHelper

  before(:each) do
    @qty = 2
    @merch1, @merch2 = create_list(:merchant, @qty)
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_merchants_path
      @merchants = json_data
      @merchant = @merchants.first
    end

    it 'Sends a list of Merchants' do
      expect(response).to be_successful
      expect(@merchants.count).to eq(@qty)
      merch2 = @merchants.last
      expect(@merchant["attributes"]['id']).to eq(@merch1.id)
      expect(merch2["attributes"]['id']).to    eq(@merch2.id)
    end

    describe 'Merchant Public Attributes' do
      it { @merchant["attributes"]['id'].should eq(@merch1.id)}
      it { @merchant["attributes"]['name'].should eq(@merch1.name)}
    end

  end

  describe "SHOW" do

    before(:each) do
      get api_v1_merchant_path(@merch1)
      @merchant = json_data
    end

    it 'Sends a specific merchant' do
      expect(response).to be_successful
      expect(@merchant.class).to eq(Hash)
      expect(@merchant['attributes']['id']).to eq(@merch1.id)
    end

    describe 'Merchant Public Attributes' do
      it { @merchant['attributes']['id'].should eq(@merch1.id)}
      it { @merchant['attributes']['name'].should eq(@merch1.name)}
    end
  end


end
