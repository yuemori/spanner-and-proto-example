# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: error_details.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "protocol.ErrorDetail" do
    optional :reason, :string, 1
    optional :message, :string, 2
  end
end

module Protocol
  ErrorDetail = Google::Protobuf::DescriptorPool.generated_pool.lookup("protocol.ErrorDetail").msgclass
end
