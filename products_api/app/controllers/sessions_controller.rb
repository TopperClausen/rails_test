class SessionsController < ApplicationController
    def create
        user = User.find_by(email: session_params[:email])
        unless user
            render json: { message: 'Unauthorized' }, status: :unauthorized
            return
        end

        if user.authenticate(session_params[:password])
            render json: { message: "Success", jwt: user.jwt }
        else
            render json: { message: 'Unauthorized' }, status: :unauthorized 
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
