class StationsController < ApplicationController
  before_action :authorize_user, only: %i[show create update destroy assign_to_location assign_to_warehouse search]
  before_action :set_station, only: %i[show update destroy assign_to_location assign_to_warehouse]
  before_action :authenticate_user, only: :index

  def index
    @stations = Station.all
    render json: @stations
  end

  def show
    render json: @station
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      render json: @station, status: :created
    else
      render json: @station.errors, status: :unprocessable_content
    end
  end

  def update
    if @station.update(station_params)
      render json: @station
    else
      render json: @station.errors, status: :unprocessable_content
    end
  end

  def destroy
    @station.destroy
  end

  def assign_to_location
    if @station.update(location_id: params[:location_id])
      render json: @station
    else
      render json: @station.errors, status: :unprocessable_content
    end
  end

  def assign_to_warehouse
    if @station.update(warehouse_id: params[:warehouse_id])
      render json: @station
    else
      render json: @station.errors, status: :unprocessable_content
    end
  end

  def search
    @stations = if params[:query].present?
                  Station.where("name LIKE ?", "%#{params[:query]}%").page(params[:page]).per(10)
                else
                  Station.page(params[:page]).per(10)
                end
    render json: @stations
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end
end
