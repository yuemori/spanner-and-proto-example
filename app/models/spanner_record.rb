class SpannerRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :spanner, reading: :spanner }
end
