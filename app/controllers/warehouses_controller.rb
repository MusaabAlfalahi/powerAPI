class WarehousesController < ApplicationController
  before_action :authorize_user
  before_action :set_warehouse, only: %i[show update destroy]

  def index
    @warehouses = Warehouse.all
    render json: @warehouses
  end

  def show
    render json: @warehouse
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      render json: @warehouse, status: :created
    else
      render json: @warehouse.errors, status: :unprocessable_content
    end
  end

  def update
    if @warehouse.update(warehouse_params)
      render json: @warehouse
    else
      render json: @warehouse.errors, status: :unprocessable_content
    end
  end

  def destroy
    @warehouse.destroy
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :location_id)
  end

  def authorize_user
    unless current_user.isAdmin == "admin"
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
