# app/controllers/power_banks_controller.rb
class PowerBanksController < ApplicationController
  before_action :authorize_user, only: %i[index show create update destroy assign_to_station assign_to_warehouse assign_to_user search]
  before_action :set_power_bank, only: %i[show update destroy take return assign_to_station assign_to_warehouse assign_to_user]
  before_action :authenticate_user, only: %i[index_available take return]

  def index
    @power_banks = PowerBank.order(:id).page(params[:page]).per(10)
    render json: @power_banks
  end

  def index_available
    @power_banks = PowerBank
                     .where(status: 'available').where.not(station_id: nil)
                     .order(:id).page(params[:page]).per(10)
    render json: @power_banks
  end

  def show
    render json: @power_bank
  end

  def create
    @power_bank = PowerBank.new(power_bank_params)
    if @power_bank.save
      render json: @power_bank, status: :created
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def update
    if @power_bank.update(power_bank_params)
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def destroy
    @power_bank.destroy
  end

  def take
    if @power_bank.update(user: current_user, status: 'in_use')
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def return
    if @power_bank.update(user: nil, status: 'available')
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def assign_to_station
    if @power_bank.update(station_id: params[:station_id])
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def assign_to_warehouse
    if @power_bank.update(warehouse_id: params[:warehouse_id])
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def assign_to_user
    if @power_bank.update(user_id: params[:user_id])
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_content
    end
  end

  def search
    @power_banks = if params[:query].present?
                     PowerBank.where("name LIKE ?", "%#{params[:query]}%").page(params[:page]).per(10)
                   else
                     PowerBank.page(params[:page]).per(10)
                   end
    render json: @power_banks
  end

  private

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

  def power_bank_params
    params.require(:power_bank).permit(:name, :status, :station_id, :warehouse_id, :user_id)
  end
end