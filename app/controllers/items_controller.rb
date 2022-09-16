class ItemsController < ApplicationController

 def index
  if params[:user_id]
    user = User.find(params[:user_id])
    items = user.items
  else
    items = Item.all
    #byebug
    #return render json: items, status: :ok
  end
  render json: items, include: :user, status: :ok
rescue ActiveRecord::RecordNotFound => e
  return render json: {errors: "Not found"}, status: :not_found
 end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.find(params[:id])
    else
      item = Item.find(params[:id])
    end
    render json: item, include: :user
  rescue ActiveRecord::RecordNotFound => e
    return render json: {errors: "Not found"}, status: :not_found
  end

  def create
    if(params[:user_id])
      user = User.find(params[:user_id])
      #byebug
      item = user.items.create!(items_params)
    end
    render json: item, status: :created
  rescue ActiveRecord::RecordNotFound => e
    return render json: {errors: "Not found"}, status: :not_found
  end

end

private

def items_params
  params.permit(:name,:description,:price,:user_id)
end