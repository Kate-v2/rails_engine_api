require "rails_helper"

RSpec.describe "TransactionsAPI" do

  before(:each) do
    @qty = 2
    @trans1, @trans2 = create_list(:transaction, @qty)
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_transactions_path
      @transactions = JSON.parse(response.body)["data"]
      @transaction  = @transactions.first["attributes"]
    end

    it "Sends a list of transactions" do
      expect(response).to be_successful
      expect(@transactions.count).to eq(@qty)

      expect(@transaction['id']).to eq(@trans1.id)

      trans2 = @transactions.last['attributes']
      expect(trans2['id']).to eq(@trans2.id)
    end

    describe 'Transaction Public Attributes' do

      it 'ID' do
        expect(@transaction['id']).to eq(@trans1.id)
      end

      it 'Credit Card Number' do
        expect(@transaction['credit_card_number']).to eq(@trans1.credit_card_number)
      end

      it 'Credit Card Expiration Date' do
        expect(@transaction['credit_card_expiration_date']).to eq(@trans1.credit_card_expiration_date)
      end

      it 'Result' do
        expect(@transaction['result']).to eq(@trans1.result)
      end
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_transaction_path(@trans1)
      @transaction = JSON.parse(response.body)['data']
    end

    it "Sends a Specific Transaction" do
      expect(response).to be_successful
      expect(@transaction.class).to eq(Hash)
      expect(@transaction['attributes']['id']).to eq(@trans1.id)
    end

    describe 'Transaction Public Attributes' do

      it 'ID' do
        expect(@transaction['attributes']['id']).to eq(@trans1.id)
      end

      it 'Credit Card Number' do
        expect(@transaction['attributes']['credit_card_number']).to eq(@trans1.credit_card_number)
      end

      it 'Credit Card Expiration Date' do
        expect(@transaction['attributes']['credit_card_expiration_date']).to eq(@trans1.credit_card_expiration_date)
      end

      it 'Result' do
        expect(@transaction['attributes']['result']).to eq(@trans1.result)
      end
    end
  end

end
