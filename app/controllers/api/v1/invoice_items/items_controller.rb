class Api::V1::InvoiceItems::ItemsController < ApplicationController

  def show
    item = InvoiceItem.find(params[:invoice_item_id]).item
    render json: ItemSerializer.new(item)
  end

end
