class User < SpannerRecord
  validates :name, presence: true
  validates :device_id, presence: true
end
