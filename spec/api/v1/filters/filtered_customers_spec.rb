require "rails_helper"
require "api_helper"

RSpec.describe "Customer Filtering API" do
  include APIHelper

  describe 'Find' do

    describe 'it filters by first or last name or id' do

      before(:each) do
        @customer1, @customer2, @customer3 = create_list(:customer, 3)
      end

      it 'finds by first name' do
        name       = @customer1.first_name
        name_up    = @customer1.first_name.upcase
        name_down  = @customer1.first_name.downcase
        name_camel = @customer1.first_name.capitalize

        get api_v1_customers_find_path(first_name: name)
        @customer = json_data

        expect(response).to be_successful
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_path(first_name: name_up)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_path(first_name: name_down)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_path(first_name: name_camel)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)
      end

      it 'finds by last name' do
        name       = @customer1.last_name
        name_up    = @customer1.last_name.upcase
        name_down  = @customer1.last_name.downcase
        name_camel = @customer1.last_name.capitalize

        get api_v1_customers_find_path(last_name: name)
        @customer = json_data

        expect(response).to be_successful
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_path(last_name: name_up)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_path(last_name: name_down)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_path(last_name: name_camel)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)
      end

      it 'finds by id' do
        id = @customer1.id
        get api_v1_customers_find_path(id: id)
        @customer = json_data

        expect(response).to be_successful
        expect(@customer.class).to eq(Hash)
        expect(@customer['attributes']['id']).to eq(id)
      end

    end

    describe 'it filters by created or updated at date' do

      before(:each) do
        @customer1 = create(:customer)
        sleep(1)
        @customer2 = create(:customer)
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@customer1.created_at).to_not eq(@customer2.created_at)
        date = @customer1.created_at

        get api_v1_customers_find_path(created_at: date)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        date = @customer2.created_at
        get api_v1_customers_find_path(created_at: date)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@customer1.updated_at).to_not eq(@customer2.updated_at)
        date = @customer1.updated_at

        get api_v1_customers_find_path(updated_at: date)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        date = @customer2.updated_at
        get api_v1_customers_find_path(updated_at: date)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer2.id)
      end
    end

  end




  describe 'Find All' do

    describe 'it filters by first or last name or id' do

      before(:each) do
        @customer1, @customer2, @customer3 = create_list(:customer, 3)
      end

      it 'finds by first name' do
        name       = @customer1.first_name
        name_up    = @customer1.first_name.upcase
        name_down  = @customer1.first_name.downcase
        name_camel = @customer1.first_name.capitalize

        get api_v1_customers_find_all_path(first_name: name)
        @customers = json_data
        @customer = @customers.first

        expect(response).to be_successful
        expect(@customers.class).to eq(Array)
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_all_path(first_name: name_up)
        @customers = json_data
        @customer = @customers.first
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_all_path(first_name: name_down)
        @customers = json_data
        @customer = @customers.first
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_all_path(first_name: name_camel)
        @customers = json_data
        @customer = @customers.first
        expect(@customer['attributes']['id']).to eq(@customer1.id)
      end

      it 'finds by last name' do
        name       = @customer1.last_name
        name_up    = @customer1.last_name.upcase
        name_down  = @customer1.last_name.downcase
        name_camel = @customer1.last_name.capitalize

        get api_v1_customers_find_all_path(last_name: name)
        @customers = json_data
        @customer = @customers.first

        expect(response).to be_successful
        expect(@customers.class).to eq(Array)
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_all_path(last_name: name_up)
        @customers = json_data
        @customer = @customers.first
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_all_path(last_name: name_down)
        @customers = json_data
        @customer = @customers.first
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        get api_v1_customers_find_all_path(last_name: name_camel)
        @customers = json_data
        @customer = @customers.first
        expect(@customer['attributes']['id']).to eq(@customer1.id)
      end

      it 'finds by id' do
        id = @customer1.id
        get api_v1_customers_find_all_path(id: id)
        @customers = json_data
        @customer = @customers.first

        expect(response).to be_successful
        expect(@customers.class).to eq(Array)
        expect(@customer['attributes']['id']).to eq(id)
      end
    end

    describe 'it filters by created or updated at' do

      before(:each) do
        @customer1 = create(:customer)
        sleep(1)
        @customer2 = create(:customer)
      end

      it 'created_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@customer1.created_at).to_not eq(@customer2.created_at)
        date = @customer1.created_at

        get api_v1_customers_find_all_path(created_at: date)
        @customers = json_data
        @customer  = @customers.first
        expect(response).to be_successful
        expect(@customers.to_a).to eq(Array)
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        date = @customer2.created_at
        get api_v1_customers_find_path(created_at: date)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer2.id)
      end

      it 'updated_at' do
        skip("can't figure out ApplicationRecord Date methods")
        expect(@customer1.updated_at).to_not eq(@customer2.updated_at)
        date = @customer1.updated_at

        get api_v1_customers_find_all_path(updated_at: date)
        @customers = json_data
        @customer  = @customers.first
        expect(response).to be_successful
        expect(@customers.to_a).to eq(Array)
        expect(@customer['attributes']['id']).to eq(@customer1.id)

        date = @customer2.updated_at
        get api_v1_customers_find_path(updated_at: date)
        @customer = json_data
        expect(@customer['attributes']['id']).to eq(@customer2.id)
      end
    end
  end


  describe 'Random' do

    before(:each) do
      @customer1, @customer2, @customer3 = create_list(:customer, 3)
    end

    it 'returns a single random customer' do
      get api_v1_customers_random_path
      @customer = json_data
      expect(@customer.class).to eq(Hash)
      expect(@customer['attributes']).to include('id')
    end

  end

end
