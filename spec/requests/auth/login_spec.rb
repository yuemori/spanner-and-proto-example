require 'rails_helper'

RSpec.describe "auth/login" do
  before do
    post "/auth/create_user", params: Protocol::SpannerExample::CreateUserRequest.new(device_id: device_id, name: SecureRandom.alphanumeric), as: :protobuf
  end
  let(:device_id) { SecureRandom.uuid }
  let(:session_token) { SecureRandom.base64(13) }

  context 'when valid request' do
    it 'returns ok response' do
      post "/auth/create_session", params: Protocol::SpannerExample::CreateSessionRequest.new(device_id: device_id), as: :protobuf 
      expect(response).to have_http_status 200

      session_token = Protocol::SpannerExample::CreateSessionResponse.decode(response.body).session_token

      post "/auth/login", params: Protocol::SpannerExample::LoginRequest.new(session_token: session_token), as: :protobuf

      expect(response).to have_http_status 200
      resp = Protocol::SpannerExample::LoginResponse.decode(response.body)

      expect(resp.metadata.status_code).to equal(:OK)
      expect(resp.user_id).to be_present
    end
  end

  context 'when invalid request' do
    context "when device_id is blank" do
      it 'returns invalid_argument response' do
        post "/auth/login", params: Protocol::SpannerExample::LoginRequest.new(session_token: SecureRandom.base64(13)), as: :protobuf

        expect(response).to have_http_status 200
        resp = Protocol::SpannerExample::LoginResponse.decode(response.body)

        expect(resp.metadata.status_code).to equal(:INVALID_ARGUMENT)
      end
    end
  end
end
