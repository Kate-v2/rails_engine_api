class Api::V1::InvoicesController < ApplicationController

  def index
    invoices = choose_invoices
    render json: InvoiceSerializer.new(invoices)
  end

  def show
    invoice = choose_invoices
    render json: InvoiceSerializer.new(invoice)
  end


  private

  def choose_invoices
    path = request.path
    return Invoice.all               if path == api_v1_invoices_path
    return Invoice.find(params[:id]) if params[:id] && path == api_v1_invoice_path(params[:id])
    # return Invoice.where(merchant_id: params[:merchant_id]) if params[:merchant_id] && path == api_v1_merchant_invoices_path(params[:merchant_id])
    return Invoice.where(customer_id: params[:customer_id]) if params[:customer_id] && path == api_v1_customer_invoices_path(params[:customer_id])
    return Transaction.find(params[:transaction_id]).invoice if params[:transaction_id] && path == api_v1_transaction_invoice_path(params[:transaction_id])
  end


end
