class Api::V1::CustomersController < ApplicationController

  def index
    customers = choose_customers
    render json: CustomerSerializer.new(customers)
  end

  def show
    customer = choose_customers
    render json: CustomerSerializer.new(customer)
  end

  private

  def choose_customers
    path = request.path
    return Customer.all               if path == api_v1_customers_path
    return Customer.find(params[:id]) if path == api_v1_customer_path(params[:id]) && params[:id]
  end


end
