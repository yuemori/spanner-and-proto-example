class MasterDataRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :master, reading: :master }
end
