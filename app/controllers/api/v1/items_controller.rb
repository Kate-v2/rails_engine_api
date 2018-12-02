class Api::V1::ItemsController < ApplicationController

  def index
    items = choose_items
    render json: ItemSerializer.new(items)
  end

  def show
    item = choose_items
    render json: ItemSerializer.new(item)
  end


  private

  def choose_items
    path = request.path
    return Item.all               if path == api_v1_items_path
    return Item.find(params[:id]) if params[:id] && path == api_v1_item_path(params[:id])
    # return Item.where(merchant_id: params[:merchant_id]) if params[:merchant_id] && path == api_v1_merchant_items_path(params[:merchant_id])
    return InvoiceItem.where(invoice_id: params[:invoice_id]).items if params[:invoice_id] && path = api_v1_invoice_items_path(params[:invoice_id])
  end




end
