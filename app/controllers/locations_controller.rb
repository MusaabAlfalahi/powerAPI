# app/controllers/locations_controller.rb
class LocationsController < ApplicationController
  before_action :authorize_user, only: %i[show create update destroy search]
  before_action :set_location, only: %i[show update destroy]
  def index
    @locations = Location.all
    render json: @locations
  end

  def show
    render json: @location
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_content
    end
  end

  def update
    if @location.update(location_params)
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_content
    end
  end

  def destroy
    @location.destroy
  end

  def search
    @locations = if params[:query].present?
                   Location.where("name LIKE ?", "%#{params[:query]}%").page(params[:page]).per(10)
                 else
                   Location.page(params[:page]).per(10)
                 end
    render json: @locations
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address)
  end
end
