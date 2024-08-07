class Auth::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token

    render json: {
      code: 200,
      message: 'Logged in successfully.',
      token: @token,
      user: UserSerializer.render_as_json(resource, view: :default)
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               'c979ab39fe5ce829d39eb46c88555055ac5fb38e5d3ee60e1f58df88105eb211ef1c08d4f3f1458af67fd850da993ee635a11ad14932b33564775da98687ae5d').first

      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
