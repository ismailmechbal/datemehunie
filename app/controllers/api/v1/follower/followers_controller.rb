module Api::V1::Follower
  class FollowersController < ApiController
    before_action :authenticate_with_token!, only: [:create, :destroy]

    # GET /v1/followers
    def index
      unless params[:user_id]
        render json: current_user.follows
      else
        if User.exists?(params[:user_id])
          user = User.find(params[:user_id])
          render json: user.follows
        else
          render json: { status: 401 }
        end
      end
    end

    def create
      unless current_user.follows.exists? followers_params
        @follow = Follow.new followers_params
        @follow.follower = current_user
        @follow.save
      else
        @follow = current_user.follows.find_by followers_params
        @follow.unblock!
      end
      render json: { status: 200 }
    end

    def destroy
      if current_user.follows.exists? params[:id]
        @follow = current_user.follows.find params[:id]
        @follow.block!
        render json: { status: 200 }
      else
        render json: { status: 401 }
      end
    end

    private

    def followers_params
      params.require(:followers).permit(:followable_id, :followable_type)
    end
  end
end