class Api::V1::Merchants::CustomersController < ApplicationController

  def favorite_customer
    customer = Merchant.favorite_customer(params[:merchant_id])
    render json: CustomerSerializer.new(customer)
  end

  def pending
    customers = Merchant.pending_customers(params[:merchant_id])
    render json: CustomerSerializer.new(customers)
  end

end
