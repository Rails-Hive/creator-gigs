class ApplicationController < ActionController::API

    def render_response(class_name, object, message, status, type)
        render json: {
            data: ActiveModelSerializers::SerializableResource.new(object, each_serializer: class_name),
            message: [message],
            status: status,
            type: type,
        }
    end
end
