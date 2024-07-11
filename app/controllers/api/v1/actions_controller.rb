class Api::V1::ActionsController < Api::V1::ApplicationController
  before_action :set_api_v1_action, only: %i[show update destroy]

  # GET /api/v1/actions
  def index
    @api_v1_actions = Action.all

    render json: @api_v1_actions
  end

  # GET /api/v1/actions/1
  def show
    render json: @api_v1_action
  end

  # POST /api/v1/actions
  def create
    @api_v1_action = Action.new(api_v1_action_params)

    if @api_v1_action.save
      render json: @api_v1_action, status: :created, location: @api_v1_action
    else
      render json: @api_v1_action.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/actions/1
  def update
    if @api_v1_action.update(api_v1_action_params)
      render json: @api_v1_action
    else
      render json: @api_v1_action.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/actions/1
  def destroy
    @api_v1_action.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_action
    @api_v1_action = Action.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_action_params
    params.fetch(:api_v1_action, {})
  end
end
