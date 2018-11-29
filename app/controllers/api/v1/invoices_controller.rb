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
    return Invoice.find(params[:id]) if path == api_v1_invoice_path(params[:id]) && params[:id]
  end


end
