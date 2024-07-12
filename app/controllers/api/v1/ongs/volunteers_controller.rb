class Api::V1::Ongs::VolunteersController < Api::V1::ApplicationController
  before_action :set_ong

  # GET /api/v1/ongs/:ong_id/volunteers
  def index
    @volunteers = @ong.volunteers

    render json: { data: serialize_models(@volunteers) }, status: :ok
  end

  private

  def set_ong
    @ong = Ong.find(params[:ong_id])
  end
end
