class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find_by id: params[:id]
    unless @restaurant
      flash[:danger] = I18n.t "restaurant.show_message"
      redirect_to restaurants_path
    end
  end

  def edit
  end
end
