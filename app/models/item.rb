class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :is_checked, inclusion: { in: [true, false] }

  belongs_to :list
  
  after_save :touch_list
  after_destroy :touch_list

  private

  def touch_list
    list.touch(:items_updated_at)
  end
end
