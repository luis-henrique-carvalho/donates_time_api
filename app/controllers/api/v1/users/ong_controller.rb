class Api::V1::Users::OngController < Api::V1::ApplicationController
  before_action :set_user
  before_action :set_ong
  before_action :authenticate_user!
  before_action :authorize_users_ong

  def index
    render json: { data: OngSerializer.render_as_json(@ong, view: :overview) }, status: :ok
  end

  private

  def authorize_users_ong
    authorize @ong, policy_class: User::OngPolicy
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_ong
    @ong = Ong.with_stats.find_by(user: @user)
  end
end
