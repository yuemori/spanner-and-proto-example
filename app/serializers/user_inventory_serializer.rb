class UserInventorySerializer
  def serialize(user_inventory)
    Protocol::Rpc::UserInventory.new(
      user_items: user_items(user_inventory.items),
      user_crystal: user_crystal(user_inventory.crystal),
      user_cards: user_cards(user_inventory.cards)
    )
  end

  private

  def user_cards(user_cards)
    user_cards.map do |card|
      Protocol::Rpc::UserCard.new(
        user_id: Protocol::Core::UserId.new(value: card.user_id),
        card_id: card.card_id,
        exp: card.exp,
        level: card.level,
      )
    end
  end

  def user_crystal(user_crystal)
    Protocol::Rpc::UserCrystal.new(
      free_count: user_crystal.free_count,
      paid_count: user_crystal.paid_count,
      user_id: Protocol::Core::UserId.new(value: user_crystal.user_id)
    )
  end

  def user_items(user_items)
    user_items.map do |item|
      Protocol::Rpc::UserItem.new(
        item_category: item.item_category,
        item_id: item.item_id,
        count: item.count,
        user_id: Protocol::Core::UserId.new(value: item.user_id)
      )
    end
  end
end
