# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: masterdata/card.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "protocol.master_data.Card" do
    optional :id, :int32, 1
    optional :name, :string, 2
  end
end

module Protocol
  module MasterData
    Card = Google::Protobuf::DescriptorPool.generated_pool.lookup("protocol.master_data.Card").msgclass
  end
end