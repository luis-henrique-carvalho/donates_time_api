class Api::V1::ApplicationController < ApplicationController
  include Pagy::Backend
  rescue_from StandardError, with: :handle_standard_error
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def default_messages(entity, name: nil)
    {
      created: "#{entity} #{name ? "#{name} " : ''}created successfully",
      updated: "#{entity} #{name ? "#{name} " : ''}updated successfully",
      deleted: "#{entity} #{name ? "#{name} " : ''}deleted successfully"
    }
  end

  # Returns status 404 Not Found
  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # Returns status 422 Unprocessable Entity
  def record_invalid(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  # Returns status 403 Forbidden
  def user_not_authorized(_exception)
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end

  # Returns status 500 Internal Server Error
  def handle_standard_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end

  protected

  def serialize_model(model)
    return {} unless model.present?

    serializer_class = "#{model.class}Serializer".constantize
    serializer_class.new(model).serializable_hash[:data]
  end

  def serialize_models(models)
    return [] unless models.present?

    serializer_class = "#{models.first.class}Serializer".constantize
    serializer_class.new(models, is_collection: true).serializable_hash[:data]
  end
end
