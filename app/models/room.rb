class Room < ApplicationRecord
  belongs_to :exhibition_center
  has_many :exhibitions
  has_many :exhibits

  validates :name, presence: true, uniqueness: { scope: :exhibition_center_id }
  validates :width, :height, :depth, presence: true, numericality: { greater_than: 0 }
  validate :reasonable_dimensions

  private

  def reasonable_dimensions
    max_ratio = 10
    ratios = [
      width.to_f / height.to_f,
      height.to_f / width.to_f,
      width.to_f / depth.to_f,
      depth.to_f / width.to_f,
      height.to_f / depth.to_f,
      depth.to_f / height.to_f
    ]

    if ratios.any? { |ratio| ratio > max_ratio }
      errors.add(:base, "Room dimensions must maintain reasonable proportions (max ratio 1:10)")
    end
  end
end
