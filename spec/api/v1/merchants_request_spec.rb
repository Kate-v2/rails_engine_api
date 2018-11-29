require "rails_helper"

RSpec.describe "MerchantsAPI" do

  before(:each) do
    @qty = 2
    @merch1, @merch2 = create_list(:merchant, @qty)
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_merchants_path
      @merchants = JSON.parse(response.body)["data"]
      @merchant = @merchants.first["attributes"]
    end

    it 'Sends a list of Merchants' do
      expect(response).to be_successful
      expect(@merchants.count).to eq(@qty)
      expect(@merchant['id']).to eq(@merch1.id)
      merch2 = @merchants.last["attributes"]
      expect(merch2['id']).to eq(@merch2.id)
    end

    describe 'Merchant Public Attributes' do
      it { @merchant['id'].should eq(@merch1.id)}
      it { @merchant['name'].should eq(@merch1.name)}
    end

  end

  describe "SHOW" do

    before(:each) do
      get api_v1_merchant_path(@merch1)
      @merchant = JSON.parse(response.body)["data"]
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
