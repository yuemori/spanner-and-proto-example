module Protocol
  class RpcMethod
    attr_accessor :service_name, :method_name, :request_type, :response_type

    def initialize(service_name, method_name, request_type, response_type)
      @service_name = service_name
      @method_name = method_name
      @request_type = request_type
      @response_type = response_type
    end
  end

  class Service
    class << self
      attr_accessor :service_name
    end

    def self.rpcs
      @rpcs ||= {}
    end

    def self.rpc(method, request_type, response_type)
      rpcs[method] = RpcMethod.new(service_name, method, request_type, response_type)
    end
  end
end
