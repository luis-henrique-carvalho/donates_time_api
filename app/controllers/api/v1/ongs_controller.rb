class Api::V1::OngsController < Api::V1::ApplicationController
  before_action :set_ong, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_ong, only: %i[update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :handle_standard_error
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /ongs
  def index
    ongs = Ong.all
    render json: serialize_models(ongs), status: :ok
  end

  # GET /ongs/:id
  def show
    render json: serialize_model(@ong), status: :ok
  end

  # POST /ongs
  def create
    ong = Ong.new(ong_params.merge(user_id: current_user.id))
    ong.save!
    render json: serialize_model(ong), status: :created
  end

  # PATCH/PUT /ongs/:id
  def update
    @ong.update!(ong_params)
    render json: serialize_model(@ong), status: :ok
  end

  # DELETE /ongs/:id
  def destroy
    @ong.destroy
    head :no_content
  end

  private

  def set_ong
    @ong = Ong.find(params[:id])
  end

  def authorize_ong
    authorize @ong, policy_class: OngPolicy
  end

  def ong_params
    params.require(:ong).permit(:name, :city, :state, :description, :email, :category)
  end

  def serialize_model(model)
    OngSerializer.new(model).serializable_hash
  end

  def serialize_models(models)
    OngSerializer.new(models, is_collection: true).serializable_hash
  end
end