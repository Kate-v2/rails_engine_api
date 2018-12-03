class Api::V1::Customers::FiltersController < ApplicationController

  def index
    customers = choose_method
    render json: CustomerSerializer.new(customers)
  end

  def show
    customer = choose_method.first
    render json: CustomerSerializer.new(customer)
  end

  def random
    customer = Customer.random
    render json: CustomerSerializer.new(customer)
  end


  private

  def choose_method
    return Customer.id_is(params[:id])                 if params[:id]
    return Customer.first_name_is(params[:first_name]) if params[:first_name]
    return Customer.last_name_is(params[:last_name])   if params[:last_name]
    return Customer.created_on(params[:created_at])    if params[:created_at]
    return Customer.updated_on(params[:updated_at])    if params[:updated_at]
  end

end
