class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    transactions = Transaction.where(invoice_id: params[:invoice_id])
    render json: TransactionSerializer.new(transactions)
  end

end
