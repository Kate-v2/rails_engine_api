class Api::V1::Transactions::InvoicesController < ApplicationController

  def show
    invoice = Transaction.find(params[:transaction_id]).invoice
    render json: InvoiceSerializer.new(invoice)
  end

end
