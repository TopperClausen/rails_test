module V1
    class UsersController < ApplicationController
        def create
            user = User.new(user_params)
            if user.valid?
                user.save!
                success_response(data: { jwt: user.jwt })
            else
                bad_request_response(errors: user.errors)
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
