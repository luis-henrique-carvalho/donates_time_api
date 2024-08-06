class Api::V1::Actions::VolunteersController < Api::V1::ApplicationController
  before_action :set_action

  # GET /api/v1/actions/:action_id/volunteers
  def index
    @volunteers = @action.volunteers

    render json: { data: VolunteerSerializer.render_as_json(@volunteers, view: :default) }, status: :ok
  end

  private

  def set_action
    @action = Action.find(params[:action_id])
  end
end
