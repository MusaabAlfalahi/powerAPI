class StationsController < ApplicationController
  before_action :authorize_user
  before_action :set_station, only: %i[show update destroy]

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

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end

  def authorize_user
    unless current_user.isAdmin == "admin"
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
