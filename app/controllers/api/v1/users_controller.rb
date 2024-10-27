class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authorize_user, only: %i[show]
  before_action :authenticate_user!, only: %i[show]
  before_action :set_user, only: [:show]

  def show
    render json: { data: UserSerializer.render_as_json(@user, view: :private) }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user, policy_class: UserPolicy
  end
end
