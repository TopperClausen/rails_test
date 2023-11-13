module V1
    class ApplicationController < ActionController::API
        before_action :validate_apikey

        def validate_apikey
            key = request.headers["x-api-key"]
            apikey = Apikey.find_by(key: key)
            if apikey.blank?
                unauthorized_response
            end
            apikey.present?
        end

        def authorize
            apikey_valid = validate_apikey
            return false unless apikey_valid

            jwt = request.headers[:Authorization];
            if jwt.blank?
                unauthorized_response
                return false
            end

            @user = User.from_jwt(jwt);
            if @user.blank?
                unauthorized_response
                return false
            end

            if params[:user_id].present? && @user.id != params[:user_id].to_i
                unauthorized_response
                return false
            end
        end

        def unauthorized_response
            render json: { message: 'Unauthorized' }, status: :unauthorized
        end

        def success_response(message: 'Success', data: nil, status: 200)
            render json: { message: message, data: data }, status: status
        end

        def not_found_response
            render json: { message: 'Not found' }, status: :not_found
        end

        def server_error_response
            render json: { message: 'Internal server error' }, status: 500
        end

        def bad_request_response(message: 'Bad request', errors: nil)
            render json: { message: message, errors: errors }, status: :bad_request
        end
    end
end
