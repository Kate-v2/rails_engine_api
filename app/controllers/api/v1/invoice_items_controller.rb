class Api::V1::InvoiceItemsController < ApplicationController

  def index
    inv_items = InvoiceItem.all
    render json: InvoiceItemSerializer.new(inv_items)
  end

  def show
    inv_item = InvoiceItem.find(params[:id])
    render json: InvoiceItemSerializer.new(inv_item)
  end

end
