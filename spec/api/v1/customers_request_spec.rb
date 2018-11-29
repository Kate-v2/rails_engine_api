require "rails_helper"

RSpec.describe "MerchantsAPI" do

  before(:each) do
    @qty = 2
    @customer1, @customer2 = create_list(:customer, @qty)
  end

  describe 'INDEX' do

    before(:each) do
      get api_v1_customers_path
      @customers = JSON.parse(response.body)["data"]
      @customer  = @customers.first["attributes"]
    end

    it "Sends a list of Merchants" do
      expect(response).to be_successful
      expect(@customers.count).to eq(@qty)
      expect(@customer['id']).to  eq(@customer1.id)
      customer2 = @customers.last["attributes"]
      expect(customer2['id']).to  eq(@customer2.id)
    end

    describe 'Customer Public Attributes' do
      it { @customer['id'].should         eq(@customer1.id)}
      it { @customer['first_name'].should eq(@customer1.first_name)}
      it { @customer['last_name'].should  eq(@customer1.last_name)}
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_customer_path(@customer1)
      @customer = JSON.parse(response.body)['data']
    end

    it 'Sends a specific merchant' do
      expect(response).to be_successful
      expect(@customer.class).to eq(Hash)
      expect(@customer['attributes']['id']).to eq(@customer1.id)
    end

    describe 'Customer Public Attributes' do
      it { @customer['attributes']['id'].should         eq(@customer1.id)}
      it { @customer['attributes']['first_name'].should eq(@customer1.first_name)}
      it { @customer['attributes']['last_name'].should  eq(@customer1.last_name)}
    end
  end

end
