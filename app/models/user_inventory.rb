class UserInventory
  def self.find_by_user_id(user_id)
    user_items = UserItem.where(user_id: user_id).to_a
    user_cards = UserCard.where(user_id: user_id).to_a
    user_crystal = UserCrystal.find_or_initialize_by(user_id: user_id)

    new(user_id, user_items, user_cards, user_crystal)
  end

  attr_reader :user_id, :items, :cards, :crystal

  def initialize(user_id, user_items, user_cards, user_crystal)
    @user_id = user_id
    @items = user_items
    @cards = user_cards
    @crystal = user_crystal
  end

  def add_card(card)
    @cards << card
  end

  def add_free_crystal(count)
    @crystal.free_count += count
  end

  def add_coin(count)
    coin = @items.find { |item| item.item_category == ItemCategory.coin }
    coin = UserItem.new(item_category: ItemCategory.coin, count: 0, user_id: @user_id) unless coin
    coin.count += count
  end

  def save!
    @items.each(&:save!)
    @cards.each(&:save!)
    @crystal.save!
  end
end
