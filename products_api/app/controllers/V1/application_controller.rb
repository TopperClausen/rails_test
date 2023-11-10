module V1
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

        def success_response(message: 'Success', data:, status: 200)
            render json: { message: message, data: data }, status: status
        end

        def not_found_response
            render json: { message: 'Not found' }, status: :not_found
        end

        def server_error_response
            render json: { message: 'Internal server error' }, status: 500
        end

        def bad_request_response(message: 'Bad request')
            render json: { message: message }, status: :bad_request
        end
    end
end
