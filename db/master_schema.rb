ActiveRecord::Schema.define(version: 0) do
  create_table "cards" do |t|
    t.string "name"
  end

  create_table "initial_user_item" do |t|
    t.integer "item_category"
    t.integer "item_id"
    t.integer "count"
  end
end
