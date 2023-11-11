module V1
    class SessionsController < ApplicationController
        def create
            user = User.find_by(email: session_params[:email])
            unless user
                unauthorized_response
                return
            end

            if user.authenticate(session_params[:password])
                success_response(data: { jwt: user.jwt })
            else
                unauthorized_response
            end
        end

        private

        def session_params
            params.permit(
                :email,
                :password 
            )
        end
    end
end
