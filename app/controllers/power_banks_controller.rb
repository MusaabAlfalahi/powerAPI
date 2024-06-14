# app/controllers/power_banks_controller.rb
class PowerBanksController < ApplicationController
  before_action :authorize_user, only: %i[show create update destroy]
  before_action :set_power_bank, only: %i[show update destroy take return]
  before_action :authenticate_user, only: %i[index take return]

  def index
    @power_banks = PowerBank.all
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
    if @power_bank.status == 'in_use'
      render json: 'power bank already in use', status: 400
    end

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

  private

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

  def power_bank_params
    params.require(:power_bank).permit(:identifier, :status, :station_id, :warehouse_id, :user_id)
  end
end
