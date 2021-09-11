module Protocol
  module SpannerExample
    class AuthService < Protocol::Service
      self.service_name = :auth_service
      rpc :create_user, Protocol::SpannerExample::CreateUserRequest, Protocol::SpannerExample::CreateUserResponse
      rpc :create_session, Protocol::SpannerExample::CreateSessionRequest, Protocol::SpannerExample::CreateSessionResponse
      rpc :login, Protocol::SpannerExample::LoginRequest, Protocol::SpannerExample::LoginResponse
    end
    Protocol.register_service :auth, AuthService
  end
end
