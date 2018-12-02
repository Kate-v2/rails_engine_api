class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    items = Invoice.find(params[:invoice_id]).items
    render json: ItemSerializer.new(items)
  end

end
