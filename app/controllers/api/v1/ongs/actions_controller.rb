class Api::V1::Ongs::ActionsController < Api::V1::ApplicationController
  before_action :set_ong, only: %i[index]
  before_action :set_search, only: %i[index]

  # GET /api/v1/ongs/:ong_id/actions
  def index
    @actions = @search.result
    @pagy, @actions = pagy(@actions, items: 12)
    render json: { data: ActionSerializer.render_as_json(@actions, view: :full),
                   pagy: pagy_metadata(@pagy) }, status: :ok
  end

  private

  def set_ong
    @ong = Ong.find(params[:ong_id])
  end

  def set_search
    @search = @ong.actions.includes(volunteers: :user).ransack(params[:q])
  end
end
