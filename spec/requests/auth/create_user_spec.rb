require 'rails_helper'

RSpec.describe "auth/create_user" do
  subject { post "/auth/create_user", params: Protocol::Rpc::CreateUserRequest.new(device_id: device_id, name: name), as: :protobuf }

  context 'when valid request' do
    let(:device_id) { SecureRandom.uuid }
    let(:name) { SecureRandom.alphanumeric }

    it 'returns ok response' do
      subject

      expect(response).to have_http_status 200
      resp = Protocol::Rpc::CreateUserResponse.decode(response.body)

      expect(resp.metadata).to eq Protocol::Rpc::Metadata.new(status_code: :OK)
    end
  end

  context 'when invalid request' do
    context "when device_id is blank" do
      let(:device_id) { "" }
      let(:name) { SecureRandom.alphanumeric }

      it 'returns invalid_argument response' do
        subject
        expect(response).to have_http_status 200
        resp = Protocol::Rpc::CreateUserResponse.decode(response.body)

        expect(resp.metadata.status_code).to eq(:INVALID_ARGUMENT)
      end
    end

    context "when name is blank" do
      let(:device_id) { SecureRandom.uuid }
      let(:name) { "" }

      it 'returns invalid_argument response' do
        subject
        expect(response).to have_http_status 200
        resp = Protocol::Rpc::CreateUserResponse.decode(response.body)

        expect(resp.metadata.status_code).to eq(:INVALID_ARGUMENT)
      end
    end
  end
end
