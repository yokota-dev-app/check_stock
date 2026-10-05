class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :is_checked, presence: true

  belongs_to :list
end
