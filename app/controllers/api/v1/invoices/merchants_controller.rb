class Api::V1::Invoices::MerchantsController < ApplicationController

  def show
    merchant = Invoice.find(params[:invoice_id]).merchant
    render json: MerchantSerializer.new(merchant)
  end

end
