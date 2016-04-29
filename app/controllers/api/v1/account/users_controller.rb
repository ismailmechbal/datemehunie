module Api::V1::Account
  class UsersController < ApiController
    before_action :authenticate_with_token!, only: [:update, :destroy, :show]
    respond_to :json

    def show
      render json:current_user
      # render json: UserSerializer.new(current_user).as_json #, status: 200, location: [:api, user]
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    end

    def update
      user = current_user
      if user.update(user_params)
        render json: user, status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end