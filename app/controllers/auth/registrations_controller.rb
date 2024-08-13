class Auth::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token

      render json: {
        status: { code: 200, message: 'Signed up successfully.',
                  token: @token,
                  user: UserSerializer.render_as_json(resource, view: :default) }
      }
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
