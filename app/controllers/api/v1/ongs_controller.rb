class Api::V1::OngsController < ApplicationController
  before_action :set_ong, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_ong, only: %i[update destroy]

  # GET /ongs
  def index
    ongs = Ong.all
    render json: serialize_models(ongs), status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :not_found
  end

  # GET /ongs/1
  def show
    render json: serialize_model(@ong), status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :not_found
  end

  # POST /ongs
  def create
    ong = Ong.new(ong_params)

    if ong.save
      render json: serialize_model(ong), status: :created
    else
      render json: { errors: ong.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ongs/1
  def update
    if @ong.update(ong_params)
      render json: serialize_model(@ong), status: :ok
    else
      render json: { errors: @ong.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :not_found
  end

  # DELETE /ongs/1
  def destroy
    @ong.destroy
    head :no_content
  rescue StandardError => e
    render json: { error: e.message }, status: :not_found
  end

  private

  def authorize_ong
    ong = Ong.find(params[:id])
    authorize ong, policy_class: OngPolicy
  rescue Pundit::NotAuthorizedError
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end

  def set_ong
    @ong = Ong.find(params[:id])
  rescue StandardError => e
    render json: { error: e.message }, status: :not_found
  end

  def ong_params
    params.require(:ong).permit(:name, :city, :state, :description, :email, :category, :user_id)
  end

  def serialize_model(model)
    OngSerializer.new(model).serializable_hash
  end

  def serialize_models(models)
    OngSerializer.new(models, is_collection: true).serializable_hash
  end
end
