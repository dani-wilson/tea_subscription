class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :not_found_response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def not_found_response(error)
    error_object = Error.new(error.message, 404)
    render json: ErrorSerializer.serialize_json(error_object), status: error_object.status
  end
end
