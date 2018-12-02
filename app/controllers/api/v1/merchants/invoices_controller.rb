class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    invocies = Invoice.where(merchant_id: params[:merchant_id])
    render json: InvoiceSerializer.new(invocies)
  end

end
