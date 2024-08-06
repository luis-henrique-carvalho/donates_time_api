class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user, only: [:show]

  def show
    render json: UserSerializer.render(@user), status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
