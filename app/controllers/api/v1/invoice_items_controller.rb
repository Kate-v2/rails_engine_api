class Api::V1::InvoiceItemsController < ApplicationController

  def index
    inv_items = choose_invoice_items
    render json: InvoiceItemSerializer.new(inv_items)
  end

  def show
    inv_item = choose_invoice_items
    render json: InvoiceItemSerializer.new(inv_item)
  end


  private

  def choose_invoice_items
    path = request.path
    return InvoiceItem.all               if path == api_v1_invoice_items_path
    return InvoiceItem.find(params[:id]) if params[:id] && path == api_v1_invoice_item_path(params[:id])
    return InvoiceItem.where(invoice_id: params[:invoice_id]) if params[:invoice_id] && path == api_v1_invoice_invoice_items_path(params[:invoice_id])
  end

end
