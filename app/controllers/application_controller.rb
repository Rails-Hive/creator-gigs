class ApplicationController < ActionController::API
    
    def not_found
        render json: { error: 'not_found' }
    end
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    def render_response(class_name, object, message, status, type)
        render json: {
            data: ActiveModelSerializers::SerializableResource.new(object, each_serializer: class_name),
            message: [message],
            status: status,
            type: type,
        }
    end
end
