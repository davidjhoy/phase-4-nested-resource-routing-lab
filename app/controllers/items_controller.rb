class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
wrap_parameters format: []
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else  
      items = Item.all
    end
      render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item 
  end

  def create
    user = User.find(params[:user_id])
    new_item = user.items.create(item_params)
    render json: new_item, status: :created
  end

  private
  def render_not_found
    render json: {error: "Not Found"}, status: :not_found 
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
