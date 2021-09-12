class AddItemService
  def call(inventory, rewards)
    rewards.each do |reward|
      case reward.item_category.to_i
      when ItemCategory.card
        reward.count.times do
          card = UserCard.new(user_id: inventory.user_id, card_id: reward.item_id, exp: 0) 

          inventory.add_card(card)
        end
      when ItemCategory.crystal
        inventory.add_free_crystal(reward.count)
      when ItemCategory.coin
        inventory.add_coin(reward.count)
      else
        raise ArgumentError, "#{reward.item_category} is not supported"
      end
    end
  end
end
