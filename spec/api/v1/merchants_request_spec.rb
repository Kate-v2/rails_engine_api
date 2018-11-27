require "rails_helper"

RSpec.describe "MerchantsAPI" do

  before(:each) do
    @qty = 2
    @merch1, @merch2 = create_list(:merchant, @qty)
  end

  it 'Sends a list of Merchants' do
    get api_v1_merchants_path
    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]
    expect(merchants.count).to eq(@qty)

    merch1 = merchants.first["attributes"]
    merch2 = merchants.last["attributes"]

    expect(merch1['id']).to eq(@merch1.id)
    expect(merch2['id']).to eq(@merch2.id)
  end

  describe 'Merchant Public Attributes' do
    it 'ID' do
      get api_v1_merchants_path
      merchants = JSON.parse(response.body)["data"]
      merch1 = merchants.first["attributes"]
      expect(merch1['id']).to eq(@merch1.id)
    end

    it 'Name' do
      get api_v1_merchants_path
      merchants = JSON.parse(response.body)["data"]
      merch1 = merchants.first["attributes"]
      expect(merch1['name']).to eq(@merch1.name)
    end


  end

end
