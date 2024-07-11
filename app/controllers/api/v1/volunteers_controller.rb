class Api::V1::VolunteersController < Api::V1::ApplicationController
  before_action :set_volunteer, only: %i[show destroy]
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :authorize_volunteer

  # GET /api/v1/volunteers/:id
  def show
    render json: serialize_model(@volunteer), status: :ok
  end

  # POST /api/v1/volunteers
  def create
    @volunteer = Volunteer.new(volunteer_params.merge(user_id: current_user.id))
    @volunteer.save!
    render json: serialize_model(@volunteer), status: :created
  end

  # DELETE /api/v1/volunteers/:id
  def destroy
    @volunteer.destroy
    head :no_content
  end

  private

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def authorize_volunteer
    authorize @volunteer, policy_class: VolunteerPolicy
  end

  def volunteer_params
    params.require(:volunteer).permit(:action_id)
  end

  def serialize_model(model)
    VolunteerSerializer.new(model).serializable_hash
  end
end
