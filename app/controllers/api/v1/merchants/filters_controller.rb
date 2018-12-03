class Api::V1::Merchants::FiltersController < ApplicationController

  def index
    merchants = choose_method
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = choose_method.first
    render json: MerchantSerializer.new(merchant)
  end

  def random
    merchant = Merchant.random
    render json: MerchantSerializer.new(merchant)
  end


  private

  def choose_method
    return Merchant.id_is(params[:id])                 if params[:id]
    return Merchant.name_is(params[:name])             if params[:name]
    return Merchant.created_on(params[:created_at])    if params[:created_at]
    return Merchant.updated_on(params[:updated_at])    if params[:updated_at]
  end

end
