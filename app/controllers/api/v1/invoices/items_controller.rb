class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    # binding.pry
    # items = InvoiceItem.where(invoice_id: params[:invoice_id])
    items = Invoice.find(params[:invoice_id]).items
    render json: ItemSerializer.new(items)
  end

end
