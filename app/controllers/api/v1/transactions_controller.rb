class Api::V1::TransactionsController < ApplicationController

  def index
    transactions = choose_transactions
    render json: TransactionSerializer.new(transactions)
  end

  def show
    transaction = choose_transactions
    render json: TransactionSerializer.new(transaction)
  end


  private

  def choose_transactions
    path = request.path
    return Transaction.all               if path == api_v1_transactions_path
    return Transaction.find(params[:id]) if params[:id] && path == api_v1_transaction_path(params[:id])
  end


end
