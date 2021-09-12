class Reward
  attr_reader :item_id, :item_category, :count, :reason_type, :reason_id

  def initialize(item_category:, item_id:, count:)
    @item_category = ItemCategory.new(item_category)
    @item_id = item_id
    @count = count
  end
end
