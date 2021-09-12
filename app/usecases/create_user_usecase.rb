class CreateUserUsecase
  Response = Struct.new(:success?, :user, :inventory, :error)

  def call(device_id:, name:)
    user = nil
    inventory = nil

    SpannerRecord.transaction(isolation: :buffered_mutations) do
      user = User.new(device_id: device_id, name: name)
      user.save!

      inventory = UserInventory.find_by_user_id(user.id)
      rewards = Master::InitialUserItem.all.map do |item|
        Reward.new(
          item_category: item.item_category,
          item_id: item.item_id,
          count: item.count
        )
      end

      AddItemService.new.call(inventory, rewards)
      inventory.save!
    end

    Response.new(true, user, inventory, nil)
  rescue ActiveRecord::RecordInvalid => e
    Response.new(false, user, inventory, e)
  end
end
