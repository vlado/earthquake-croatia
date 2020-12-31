class Comment < ApplicationRecord
  belongs_to :ad, counter_cache: true
end
