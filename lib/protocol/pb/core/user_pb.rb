# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: core/user.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "protocol.core.UserId" do
    optional :value, :int64, 1
  end
end

module Protocol
  module Core
    UserId = Google::Protobuf::DescriptorPool.generated_pool.lookup("protocol.core.UserId").msgclass
  end
end
