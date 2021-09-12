class CreateUserItems < ActiveRecord::Migration[6.1]
  def change
    SpannerRecord.connection.ddl_batch do
      create_table :user_items, id: false do |t|
        t.interleave_in :users, :cascade
        t.primary_key :id
        t.parent_key :user_id
        t.integer :item_category
        t.integer :count
        t.integer :item_id

        t.timestamps
      end

      create_table :user_cards, id: false do |t|
        t.interleave_in :users, :cascade
        t.primary_key :id
        t.parent_key :user_id
        t.integer :card_id, null: false
        t.integer :exp, null: false

        t.timestamps
      end

      create_table :user_crystals, id: false do |t|
        t.interleave_in :users, :cascade
        t.primary_key :id
        t.parent_key :user_id
        t.integer :free_count, null: false
        t.integer :paid_count, null: false

        t.timestamps
      end
    end
  end
end
