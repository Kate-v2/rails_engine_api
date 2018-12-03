class Api::V1::Invoices::FiltersController < ApplicationController

  def index
    invoices = choose_method
    render json: InvoiceSerializer.new(invoices)
  end

  def show
    invoice = choose_method.first
    render json: InvoiceSerializer.new(invoice)
  end

  def random
    invoice = Invoice.random
    render json: InvoiceSerializer.new(invoice)
  end


  private

  def choose_method
    return Invoice.id_is(params[:id])               if params[:id]
    return Invoice.created_on(params[:created_at])  if params[:created_at]
    return Invoice.updated_on(params[:updated_at])  if params[:updated_at]
  end

end
