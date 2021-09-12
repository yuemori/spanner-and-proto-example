require 'rails_helper'

RSpec.describe "auth/login" do
  before do
    post "/auth/create_user", params: Protocol::Rpc::CreateUserRequest.new(device_id: device_id, name: SecureRandom.alphanumeric), as: :protobuf
  end
  let(:device_id) { SecureRandom.uuid }
  let(:session_token) { SecureRandom.base64(13) }

  context 'when valid request' do
    before do
      Master::InitialUserItem.create [
        {item_category: ItemCategory.coin, item_id: 0, count: 100},
        {item_category: ItemCategory.card, item_id: 1, count: 1},
        {item_category: ItemCategory.crystal, item_id: 0, count: 1000},
      ]
    end

    it 'returns ok response' do
      post "/auth/create_session", params: Protocol::Rpc::CreateSessionRequest.new(device_id: device_id), as: :protobuf 
      expect(response).to have_http_status 200

      session_token = Protocol::Rpc::CreateSessionResponse.decode(response.body).session_token

      post "/auth/login", params: Protocol::Rpc::LoginRequest.new(session_token: session_token), as: :protobuf

      expect(response).to have_http_status 200
      resp = Protocol::Rpc::LoginResponse.decode(response.body)

      expect(resp.metadata).to eq Protocol::Rpc::Metadata.new(status_code: :OK)
      expect(resp.user_id).to be_present
      expect(resp.user_inventory).to be_present
    end
  end

  context 'when invalid request' do
    context "when device_id is blank" do
      it 'returns invalid_argument response' do
        post "/auth/login", params: Protocol::Rpc::LoginRequest.new(session_token: SecureRandom.base64(13)), as: :protobuf

        expect(response).to have_http_status 200
        resp = Protocol::Rpc::LoginResponse.decode(response.body)

        expect(resp.metadata.status_code).to equal(:INVALID_ARGUMENT)
      end
    end
  end
end
