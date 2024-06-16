class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']
    puts header
    token = header.split(' ').last if header
    puts token
    decoded = JsonWebToken.decode(token)
    puts decoded
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { errors: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def authorize_user
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user&.admin?
  end
end
