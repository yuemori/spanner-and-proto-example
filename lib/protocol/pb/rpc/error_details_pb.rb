# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: rpc/error_details.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "protocol.rpc.ErrorDetail" do
    optional :reason, :string, 1
    optional :message, :string, 2
  end
end

module Protocol
  module Rpc
    ErrorDetail = Google::Protobuf::DescriptorPool.generated_pool.lookup("protocol.rpc.ErrorDetail").msgclass
  end
end
