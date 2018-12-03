class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    qty = params[:quantity] ||= 1
    merchants = Merchant.most_revenue(qty)
    render json: MerchantSerializer.new(merchants)
  end

  def revenue
    rev = Merchant.total_revenue
    revenue = Revenue.new(rev)
    render json: RevenueSerializer.new(revenue)
  end

end
