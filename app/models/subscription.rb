class Subscription < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :status,
                        :frequency

  belongs_to :tea
  belongs_to :customer
end