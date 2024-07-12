class Api::V1::OngsController < Api::V1::ApplicationController
  before_action :set_ong, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_ong

  # GET /api/v1/ongs
  def index
    @ongs = Ong.all
    render json: { data: serialize_models(@ongs) }, status: :ok
  end

  # GET /api/v1/ongs/:id
  def show
    render json: { data: serialize_model(@ong) }, status: :ok
  end

  # POST /api/v1/ongs
  def create
    @ong = Ong.new(ong_params.merge(user_id: current_user.id))
    @ong.save!
    render json: { message: default_messages('Ong', name: @ong.name)[:created], data: serialize_model(@ong) },
           status: :created
  end

  # PATCH/PUT /api/v1/ongs/:id
  def update
    @ong.update!(ong_params)
    render json: { message: default_messages('Ong', name: @ong.name)[:updated], data: serialize_model(@ong) },
           status: :ok
  end

  # DELETE /api/v1/ongs/:id
  def destroy
    @ong.destroy
    render json: { message: default_messages('Ong', name: @ong.name)[:deleted], data: serialize_model(@ong) },
           status: :ok
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
    OngSerializer.new(model).serializable_hash[:data]
  end

  def serialize_models(models)
    OngSerializer.new(models, is_collection: true).serializable_hash[:data]
  end
end
