class ApplicationController < ActionController::API
    include Api::ErrorHandler
    
    def not_found
        e = Errors::NotFound.new
        render json: ErrorSerializer.new(e), status: e.status
    end
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound 
            not_found
        rescue JWT::DecodeError
            e = Errors::Unauthorized.new
            render json: ErrorSerializer.new(e), status: e.status
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

    private

    def process_operation!(klass)
        result = klass.(serialized_params)
        return render_success if result.success?
        raise Errors::Invalid.new(result['contract.default'].errors.to_h)
    end

    def serialized_params
        data = params[:data].merge(id: params[:id])
        data.reverse_merge(id: data[:id])
    end

    def render_success
        render json: serializer.new(result['model']), status: success_http_status
    end

    def success_http_status
        return 201 if params[:action] == 'create'
        return 204 if params[:action] == 'destroy'
        return 200
    end
end
