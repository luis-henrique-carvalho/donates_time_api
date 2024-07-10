class Api::V1::ApplicationController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from StandardError, with: :handle_standard_error

  private

  # Returns status 404 Not Found
  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # Returns status 422 Unprocessable Entity
  def record_invalid(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  # Returns status 500 Internal Server Error
  def handle_standard_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end

  # Returns status 403 Forbidden
  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
