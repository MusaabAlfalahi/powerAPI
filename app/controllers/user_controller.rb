class UserController < ApplicationController
  before_action :authorize_user, :create
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def authorize_user
    unless current_user.isAdmin == "admin"
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
