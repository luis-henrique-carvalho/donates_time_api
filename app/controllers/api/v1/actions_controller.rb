class Api::V1::ActionsController < Api::V1::ApplicationController
  before_action :set_action, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_action, only: %i[update destroy]

  # GET /api/v1/actions
  def index
    @actions = Action.all
    render json: serialize_models(@actions), status: :ok
  end

  # GET /api/v1/actions/:id
  def show
    render json: serialize_model(@action), status: :ok
  end

  # POST /api/v1/actions
  def create
    @action = Action.new(action_params)
    @action.save!
    render json: serialize_model(@action), status: :created
  end

  # PATCH/PUT /api/v1/actions/:id
  def update
    @action.update!(action_params)
    render json: serialize_model(@action), status: :ok
  end

  # DELETE /api/v1/actions/:id
  def destroy
    @action.destroy
    head :no_content
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

  def serialize_model(model)
    ActionSerializer.new(model).serializable_hash
  end

  def serialize_models(models)
    ActionSerializer.new(models, is_collection: true).serializable_hash
  end
end
