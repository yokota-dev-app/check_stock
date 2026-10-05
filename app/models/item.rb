class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :is_checked, inclusion: { in: [true, false] }

  belongs_to :list
end
