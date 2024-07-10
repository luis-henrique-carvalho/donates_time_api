class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split&.last
    if token
      begin
        jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
        @current_user = User.find(jwt_payload['sub'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :unauthorized
      end
    else
      render json: { error: 'Token de autenticação ausente' }, status: :unauthorized
    end
  end

  attr_reader :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
