class Api::V1::Ongs::ActionsController < Api::V1::ApplicationController
  before_action :set_ong

  def index
    @actions = @ong.actions
    render json: { data: serialize_models(@actions) }, status: :ok
  end

  private

  def set_ong
    @ong = Ong.find(params[:ong_id])
  end
end
