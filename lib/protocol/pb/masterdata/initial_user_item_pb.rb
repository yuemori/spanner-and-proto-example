# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: masterdata/initial_user_item.proto

require 'google/protobuf'

require 'core/item_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "protocol.master_data.InitialUserItem" do
    optional :item_category, :enum, 1, "protocol.core.ItemCategory"
    optional :item_id, :int32, 2
    optional :count, :int32, 3
  end
end

module Protocol
  module MasterData
    InitialUserItem = Google::Protobuf::DescriptorPool.generated_pool.lookup("protocol.master_data.InitialUserItem").msgclass
  end
end
