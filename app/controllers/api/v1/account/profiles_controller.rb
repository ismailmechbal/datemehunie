module Api::V1::Account
  class ProfilesController < ApiController
    before_action :authenticate_with_token!, only: [:create]

    # GET /v1/profiles
    def index
      if params[:tag]
        @profiles = Profile.tagged_with(params[:tag])
        render json: @profiles.limit(5)
      else
        render json: Profile.limit(5)
      end
    end

    def show
      profile = Profile.find(params[:id])
      render json: profile
    end

    def create
      profile = Profile.new(profile_params)
      if profile.save
        render json: profile, status: 200
      else
        render json: { errors: profile.errors }, status: 422
      end
    end

    def update
      profile = Profile.find(params[:id])
      if profile.update(profile_params)
        render json: profile, status: 200
      else
        render json: { errors: profile.errors }, status: 422
      end
    end

    def destroy
      profile = Profile.find(params[:id])
      if profile.destroy
        render json: { status: 200 }
      else
        render json: { errors: profile.errors }, status: 422
      end
    end

    def follow
      @profile = Profile.find(params[:id_profile])
      current_user.follow(@profile)
      render json: { status: 200 }
    end

    private

    def profile_params
      params.require(:profile).permit(:user_id, :name, :gender, :breed, :dob, :coordinates, :seeking, :body, :tag_list)
    end
  end
end