class Api::V1::Users::ActionsController < Api::V1::ApplicationController
    before_action :set_user
    before_action :set_search, only: %i[index]

    # GET /api/v1/users/:user_id/actions
    def index
        @actions = @search.result
        @pagy, @actions = pagy(@actions, items: 12)
        render json: { data: ActionSerializer.render_as_json(@actions),
                     pagy: pagy_metadata(@pagy) }, status: :ok
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end

    def set_search
        @search = @user.actions.includes(volunteers: :user).ransack(params[:q])
    end
end
