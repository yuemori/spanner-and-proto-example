module Protocol
  class AuthService < Protocol::Service
    self.service_name = :auth_service
    rpc :create_user, Protocol::CreateUserRequest, Protocol::CreateUserResponse
    rpc :create_session, Protocol::CreateSessionRequest, Protocol::CreateSessionResponse
    rpc :login, Protocol::LoginRequest, Protocol::LoginResponse
  end
  Protocol.register_service :auth, AuthService
end
