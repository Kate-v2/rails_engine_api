class Api::V1::Transactions::FiltersController < ApplicationController

  def index
    transactions = choose_method
    render json: TransactionSerializer.new(transactions)
  end

  def show
    transaction = choose_method.first
    render json: TransactionSerializer.new(transaction)
  end

  def random
    transaction = Transaction.random
    render json: TransactionSerializer.new(transaction)
  end


  private

  def choose_method
    return Transaction.id_is(params[:id])               if params[:id]
    # return Transaction.name_is(params[:name])           if params[:name]
    return Transaction.created_on(params[:created_at])  if params[:created_at]
    return Transaction.updated_on(params[:updated_at])  if params[:updated_at]
  end

end
