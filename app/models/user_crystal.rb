class UserCrystal < SpannerRecord
  attribute :free_count, default: 0
  attribute :paid_count, default: 0
end
