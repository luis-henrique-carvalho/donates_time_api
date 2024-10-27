class Api::V1::ActionsController < Api::V1::ApplicationController
  before_action :set_action, only: %i[show update destroy]
  before_action :set_search, only: %i[index]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_action

  # GET /api/v1/actions
  def index
    @actions = @search.result
    @pagy, @actions = pagy(@actions, items: 12)
    render json: { data: ActionSerializer.render_as_json(@actions, view: :full),
                   pagy: pagy_metadata(@pagy) }, status: :ok
  end

  # GET /api/v1/actions/:id
  def show
    render json: { data: ActionSerializer.render_as_json(@action, view: :full) }, status: :ok
  end

  # POST /api/v1/actions
  def create
    @action = Action.new(action_params)
    @action.save!
    render json: {
      message: default_messages('Action', name: @action.title)[:created],
      data: ActionSerializer.render_as_json(@action, view: :with_ong)
    }, status: :created
  end

  # PATCH/PUT /api/v1/actions/:id
  def update
    @action.update!(action_params)
    render json: { message: default_messages('Action', name: @action.title)[:updated],
                   data: ActionSerializer.render_as_json(@action, view: :with_ong) }, status: :ok
  end

  # DELETE /api/v1/actions/:id
  def destroy
    @action.destroy
    render json: { message: default_messages('Action', name: @action.title)[:deleted],
                   data: ActionSerializer.render_as_json(@action, view: :with_ong) }, status: :ok
  end

  private

  def set_action
    @action = Action.includes(:ong, volunteers: :user).find(params[:id])
  end

  def authorize_action
    authorize @action, policy_class: ActionPolicy
  end

  def action_params
    params.permit(:title, :description, :start_date, :end_date, :max_volunteers, :category,
                  :ong_id)
  end

  def set_search
    @search = Action.includes(:ong, volunteers: :user).ransack(params[:q])
  end
end
