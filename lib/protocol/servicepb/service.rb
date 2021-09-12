module Protocol
  class AuthService < Protocol::Service
    self.service_name = :auth_service
    rpc :create_user, Protocol::Rpc::CreateUserRequest, Protocol::Rpc::CreateUserResponse
    rpc :create_session, Protocol::Rpc::CreateSessionRequest, Protocol::Rpc::CreateSessionResponse
    rpc :login, Protocol::Rpc::LoginRequest, Protocol::Rpc::LoginResponse
  end
  Protocol.register_service :auth, AuthService
end
