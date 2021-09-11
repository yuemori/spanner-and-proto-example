class User < ApplicationRecord
  validates :name, presence: true
  validates :device_id, presence: true
end
