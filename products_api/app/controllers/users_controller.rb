class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        user = User.new(user_params)
        if user.valid?
            user.save!
            render json: { message: 'success' }
        else
            render json: { message: 'Email empty or already in use' }
        end
    end

    private

    def user_params
        params.permit(
            :full_name,
            :email,
            :password
        )
    end
end
