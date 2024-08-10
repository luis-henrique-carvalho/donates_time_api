class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split&.last
    if token
      begin
        jwt_payload = JWT.decode(token,
                                 'c979ab39fe5ce829d39eb46c88555055ac5fb38e5d3ee60e1f58df88105eb211ef1c08d4f3f1458af67fd850da993ee635a11ad14932b33564775da98687ae5d').first
        @current_user = User.find(jwt_payload['sub'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        render json: { error: "Token de autenticação inválido: #{e.message}" }, status: :unauthorized
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
