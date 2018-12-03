class Api::V1::Items::FiltersController < ApplicationController

  def index
    items = choose_method
    render json: ItemSerializer.new(items)
  end

  def show
    item = choose_method.first
    render json: ItemSerializer.new(item)
  end

  def random
    item = Item.random
    render json: ItemSerializer.new(item)
  end


  private

  def choose_method
    return Item.id_is(params[:id])               if params[:id]
    return Item.name_is(params[:name])           if params[:name]
    return Item.created_on(params[:created_at])  if params[:created_at]
    return Item.updated_on(params[:updated_at])  if params[:updated_at]
  end

end
