module V1
    class UsersController < ApplicationController
        def index
            render json: User.all
        end

        def create
            user = User.new(user_params)
            if user.valid?
                user.save!
                render json: { message: 'success', jwt: user.jwt }
            else
                render json: { message: 'failed', errors: user.errors }
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
end
