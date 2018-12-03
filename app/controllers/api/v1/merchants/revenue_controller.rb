class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    qty = params[:quantity] ||= 1
    merchants = Merchant.most_revenue(qty)
    render json: MerchantSerializer.new(merchants)
  end

  def total_revenue
    rev = Merchant.total_revenue
    revenue = Revenue.new(rev)
    render json: RevenueSerializer.new(revenue)
  end

  def revenue
    rev = Merchant.revenue(params[:merchant_id])
    revenue = Revenue.new(rev)
    render json: RevenueSerializer.new(revenue)
  end

  def most_items
    merchant = Merchant.most_items
    render json: MerchantSerializer.new(merchant)
  end


end
