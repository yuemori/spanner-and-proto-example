require 'rails_helper'

RSpec.describe "auth/create_session" do
  before { post "/auth/create_user", params: Protocol::Rpc::CreateUserRequest.new(device_id: device_id, name: SecureRandom.alphanumeric), as: :protobuf }
  subject { post "/auth/create_session", params: request, as: :protobuf }
  let(:device_id) { SecureRandom.uuid }

  context 'when valid request' do
    let(:request) { Protocol::Rpc::CreateSessionRequest.new(device_id: device_id) }

    it 'returns ok response' do
      subject

      expect(response).to have_http_status 200
      resp = Protocol::Rpc::CreateSessionResponse.decode(response.body)

      expect(resp.metadata).to eq Protocol::Rpc::Metadata.new(status_code: :OK)
      expect(resp.session_token).to be_present
    end
  end

  context 'when invalid request' do
    context "when device_id is blank" do
      let(:request) { Protocol::Rpc::CreateSessionRequest.new(device_id: SecureRandom.uuid) }

      it 'returns invalid_argument response' do
        subject
        expect(response).to have_http_status 200
        resp = Protocol::Rpc::CreateUserResponse.decode(response.body)

        expect(resp.metadata.status_code).to equal(:INVALID_ARGUMENT)
      end
    end
  end
end
