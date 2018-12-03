require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { should have_many(:invoices) }
  it { should have_many(:transactions).through(:invoices) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  describe "it can filter by: " do

    describe "first name" do

      before(:each) do
        @customer1 = create(:customer)
        @customer2 = create(:customer)
        @customer3 = create(:customer, first_name: @customer2.first_name)
      end

      it 'can find a unique name' do
        customers = Customer.first_name_is(@customer1.first_name).to_a
        customer = customers.first
        expect(customers.class).to eq(Array)
        expect(customers.count).to eq(1)
        expect(customer.class).to  eq(Customer)
        expect(customer.id).to     eq(@customer1.id)
      end

      it 'can find non-unique names' do
        customers = Customer.first_name_is(@customer2.first_name).to_a
        customer1 = customers.first
        customer2 = customers.last
        expect(customers.class).to eq(Array)
        expect(customers.count).to eq(2)
        expect(customer1.class).to  eq(Customer)
        expect(customer1.id).to     eq(@customer2.id)
        expect(customer2.id).to     eq(@customer3.id)
      end
    end

    describe "last name" do

      before(:each) do
        @customer1 = create(:customer)
        @customer2 = create(:customer)
        @customer3 = create(:customer, last_name: @customer2.last_name)
      end

      it 'can find a unique name' do
        customers = Customer.first_name_is(@customer1.first_name).to_a
        customer = customers.first
        expect(customers.class).to eq(Array)
        expect(customers.count).to eq(1)
        expect(customer.class).to  eq(Customer)
        expect(customer.id).to     eq(@customer1.id)
      end

      it 'can find non-unique names' do
        customers = Customer.last_name_is(@customer2.last_name).to_a
        customer1 = customers.first
        customer2 = customers.last
        expect(customers.class).to eq(Array)
        expect(customers.count).to eq(2)
        expect(customer1.class).to  eq(Customer)
        expect(customer1.id).to     eq(@customer2.id)
        expect(customer2.id).to     eq(@customer3.id)
      end
    end

    describe 'ID' do

      before(:each) do
        @customer1, @customer2 = create_list(:customer, 2)
      end

      it 'can find by an id' do
        customer = Customer.id_is(@customer1.id).to_a
        expect(customer.class).to eq(Array)
        expect(customer.first.class).to eq(Customer)
        expect(customer.first.id).to eq(@customer1.id)
      end
    end

    describe 'created_at & updated_at' do

      before(:each) do
        @customer1 = create(:customer)
        @date1 = @customer1.created_at.to_s
        sleep(1)
        @customer2 = create(:customer)
        @date2 = @customer2.created_at.to_s
      end

      it 'can find by created_at' do
        skip
        expect(@customer1.created_at.to_s).to_not eq(@customer2.created_at.to_s)
        customers = Customer.created_on(@customer1.created_at.to_s).to_a
        customer = customers.first
        expect(customers.class).to eq(Array)
        expect(customers.count).to eq(1)
        expect(customer.class).to  eq(Customer)
        expect(customer.id).to     eq(@customer1.id)
      end

      it 'can find by updated_at' do
        skip
        expect(@customer1.updated_at.to_s).to_not eq(@customer2.updated_at.to_s)
        customers = Customer.updated_on(@customer1.updated_at.to_s).to_a
        customer = customers.first
        expect(customers.class).to eq(Array)
        expect(customers.count).to eq(1)
        expect(customer.class).to  eq(Customer)
        expect(customer.id).to     eq(@customer1.id)
      end
    end
  end

  describe 'it can select a random customer' do

    before(:each) do
      create_list(:customer, 3)
    end

    it 'sends only one customer' do
      customer = Customer.random
      expect(customer.class).to eq(Customer)
    end
  end

end
