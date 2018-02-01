class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find_by id: params[:id]
    unless @restaurant
      flash[:danger] = I18n.t "restaurant.controller.show_message"
      redirect_to restaurants_path
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    if @restaurant.save
      flash[:success] = I18n.t "restaurant.controller.create_success"
      redirect_to restaurants_path
    else
      flash[:warning] = I18n.t "restaurant.controller.create_failed"
      render :new
    end
  end

  def edit
  end

  private

  def restaurant_params
    params.require(:restaurant).permit :name, :address
  end
end
