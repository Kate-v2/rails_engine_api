require "rails_helper"
require "api_helper"

RSpec.describe "TransactionsAPI" do
  include APIHelper

  before(:each) do
    @qty = 2
    @trans1, @trans2 = create_list(:transaction, @qty)
  end

  describe "INDEX" do

    before(:each) do
      get api_v1_transactions_path
      @transactions = json_data
      @transaction  = @transactions.first
    end

    it "Sends a list of transactions" do
      expect(response).to be_successful
      expect(@transactions.count).to eq(@qty)
      trans2 = @transactions.last
      expect(@transaction["attributes"]['id']).to eq(@trans1.id)
      expect(trans2["attributes"]['id']).to       eq(@trans2.id)
    end

    describe 'Transaction Public Attributes' do
        it { @transaction["attributes"]['id'].should                          eq(@trans1.id) }
        it { @transaction["attributes"]['credit_card_number'].should          eq(@trans1.credit_card_number) }
        it { @transaction["attributes"]['credit_card_expiration_date'].should eq(@trans1.credit_card_expiration_date) }
        it { @transaction["attributes"]['result'].should                      eq(@trans1.result) }
    end
  end

  describe 'SHOW' do

    before(:each) do
      get api_v1_transaction_path(@trans1)
      @transaction = json_data
    end

    it "Sends a Specific Transaction" do
      expect(response).to be_successful
      expect(@transaction.class).to eq(Hash)
      expect(@transaction['attributes']['id']).to eq(@trans1.id)
    end

    describe 'Transaction Public Attributes' do
      it { @transaction["attributes"]['id'].should                          eq(@trans1.id) }
      it { @transaction["attributes"]['credit_card_number'].should          eq(@trans1.credit_card_number) }
      it { @transaction["attributes"]['credit_card_expiration_date'].should eq(@trans1.credit_card_expiration_date) }
      it { @transaction["attributes"]['result'].should                      eq(@trans1.result) }
    end
  end

end
