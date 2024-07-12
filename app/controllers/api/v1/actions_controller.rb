class Api::V1::ActionsController < Api::V1::ApplicationController
  before_action :set_action, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_action

  # GET /api/v1/actions
  def index
    @actions = Action.all
    render json: { data: serialize_models(@actions) }, status: :ok
  end

  # GET /api/v1/actions/:id
  def show
    render json: { data: serialize_model(@action) }, status: :ok
  end

  # POST /api/v1/actions
  def create
    @action = Action.new(action_params)
    @action.save!
    render json: { message: default_messages('Action', name: @action.title)[:created], data: serialize_model(@action) },
           status: :created
  end

  # PATCH/PUT /api/v1/actions/:id
  def update
    @action.update!(action_params)
    render json: { message: default_messages('Action', name: @action.title)[:updated], data: serialize_model(@action) },
           status: :ok
  end

  # DELETE /api/v1/actions/:id
  def destroy
    @action.destroy
    render json: { message: default_messages('Action', name: @action.title)[:deleted], data: serialize_model(@action) },
           status: :ok
  end

  private

  def set_action
    @action = Action.find(params[:id])
  end

  def authorize_action
    authorize @action, policy_class: ActionPolicy
  end

  def action_params
    params.permit(:title, :description, :start_date, :end_date, :max_volunteers, :category,
                  :ong_id)
  end
end
