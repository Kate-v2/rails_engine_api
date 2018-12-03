class Api::V1::InvoiceItems::FiltersController < ApplicationController

  def index
    invoice_items = choose_method
    render json: InvoiceItemSerializer.new(invoice_items)
  end

  def show
    invoice_item = choose_method.first
    render json: InvoiceItemSerializer.new(invoice_item)
  end

  def random
    invoice_item = InvoiceItem.random
    render json: InvoiceItemSerializer.new(invoice_item)
  end


  private

  def choose_method
    return InvoiceItem.id_is(params[:id])               if params[:id]
    return InvoiceItem.name_is(params[:name])           if params[:name]
    return InvoiceItem.created_on(params[:created_at])  if params[:created_at]
    return InvoiceItem.updated_on(params[:updated_at])  if params[:updated_at]
  end

end
