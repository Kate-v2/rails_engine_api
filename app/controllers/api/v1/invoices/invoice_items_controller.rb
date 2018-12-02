class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    invoice_items = InvoiceItem.where(invoice_id: params[:invoice_id])
    render json: InvoiceItemSerializer.new(invoice_items)
  end

end
