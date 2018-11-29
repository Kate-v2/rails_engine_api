class Api::V1::ItemsController < ApplicationController

  def index
    items = choose_items
    render json: ItemSerializer.new(Item.all)
  end

  def show
    item = choose_items
    render json: ItemSerializer.new(item)
  end


  private

  def choose_items
    path = request.path
    return Item.all               if path == api_v1_items_path
    return Item.find(params[:id]) if path == api_v1_item_path(params[:id]) && params[:id]
  end




end
