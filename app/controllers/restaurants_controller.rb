class RestaurantsController < ApplicationController
  before_action :load_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def show; end

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

  def edit; end

  def update
    if @restaurant.update_attributes(restaurant_params)
      flash[:success] = I18n.t "restaurant.controller.update_success"
      redirect_to restaurants_path
    else
      flash[:danger] = I18n.t "restaurant.controller.update_failed"
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    flash[:success] = I18n.t "restaurant.controller.delete_success"
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit :name, :address
  end

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:id]
    unless @restaurant
      flash[:danger] = I18n.t "restaurant.controller.show_message"
      redirect_to restaurants_path
    end
  end
end
