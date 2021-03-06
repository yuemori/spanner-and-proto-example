class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  rescue_from StandardError do |e|
    render_error :UNKNOWN, e
  end

  class UnknownProtocol < StandardError; end
  rescue_from UnknownProtocol do
    render status: :internal_server_error
  end

  def render_ok(value = {}, options = {})
    render_response(value.merge(metadata: { status_code: :OK }))
  end

  def render_error(error_code, errors = [], options = {})
    error_details = wrap_errors(errors)
    render_response(metadata: { status_code: error_code, error_details: error_details })
  end

  def wrap_errors(errors)
    errors = Array(errors)

    errors.map do |error|
      case error
      when ActiveModel::Errors
        wrap_errors(error)
      when ActiveModel::Error
        Protocol::Rpc::ErrorDetail.new(reason: "RecordInvalid", message: error.full_message)
      when Exception
        Protocol::Rpc::ErrorDetail.new(reason: error.inspect, message: error.message)
      end
    end.flatten.compact
  end

  def render_response(value, options = {})
    resp = response_type.new(value)

    respond_to do |format|
      format.protobuf do
        default = { body: resp.to_proto, content_type: "application/protobuf" }
        render default.merge(options)
      end

      format.json do
        default = { json: resp.to_json }
        render default.merge(options)
      end
    end
  end

  def params
    if request.format.symbol == :protobuf
      @_params ||= Google::Protobuf.decode(rpc.request_type, request.body.read)
    else
      super
    end
  end

  def rpc
    service = Protocol.services[controller_name.to_sym]
    raise UnknownProtocol, "#{controller_name}/#{action_name} does not registered" unless service
    rpc = service.rpcs[action_name.to_sym]
    raise UnknownProtocol, "#{controller_name}/#{action_name} does not registered" unless rpc
    rpc
  end

  def request_type
    rpc.request_type
  end

  def response_type
    rpc.response_type
  end
end
