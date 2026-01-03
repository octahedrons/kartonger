class BoxFile < ApplicationRecord
  belongs_to :box

  validates :filename, presence: true
  validates :content_type, presence: true
  validates :data, presence: true

  def image?
    content_type&.start_with?("image/")
  end
end
