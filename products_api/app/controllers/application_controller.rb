class ApplicationController < ActionController::API
    def authorize
        jwt = request.headers[:Authorization];
        if jwt.blank?
            render json: { message: 'Unauthorized' }, status: :unauthorized
            return false
        end

        @user = User.from_jwt(jwt);
        if @user.blank?
            render json: { message: 'Unauthorized' }, status: :unauthorized
            return false
        end

        if params[:user_id].present? && @user.id != params[:user_id].to_i
            render json: { message: 'Unauthorized' }, status: :unauthorized
            return false
        end
    end
end
