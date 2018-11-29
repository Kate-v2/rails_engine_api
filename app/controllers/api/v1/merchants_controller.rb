class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = choose_merchants
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = choose_merchants
    render json: MerchantSerializer.new(merchant)
  end


  private

  def choose_merchants
    path = request.path
    return Merchant.all               if path == api_v1_merchants_path
    return Merchant.find(params[:id]) if path == api_v1_merchant_path(params[:id]) && params[:id]
  end



end
