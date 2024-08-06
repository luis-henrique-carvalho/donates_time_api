class Api::V1::Ongs::VolunteersController < Api::V1::ApplicationController
  before_action :set_ong
  before_action :set_search, only: %i[index]
  before_action :set_volunteer, only: %i[confirm_presence]
  before_action :authenticate_user!
  before_action :authorize_volunteer

  # GET /api/v1/ongs/:ong_id/volunteers
  def index
    @volunteers = @search.result
    @pagy, @volunteers = pagy(@volunteers, items: 12)

    render json: { data: VolunteerSerializer.render_as_json(@volunteers, view: :default),
                   pagy: pagy_metadata(@pagy) }, status: :ok
  end

  # PUT /api/v1/ongs/:ong_id/volunteers/:volunteer_id/confirm_presence
  def confirm_presence
    @volunteer.confirm_presence
    render json: { message: 'Presence confirmed successfully',
                   data: VolunteerSerializer.render_as_json(@volunteer, view: :default) }, status: :ok
  end

  private

  def authorize_volunteer
    authorize @volunteer, policy_class: Ong::VolunteerPolicy
  end

  def set_ong
    @ong = Ong.find(params[:ong_id])
  end

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def set_search
    @search = @ong.volunteers.includes(:user).ransack(params[:q])
  end
end
