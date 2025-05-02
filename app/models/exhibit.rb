class Exhibit < ApplicationRecord
  belongs_to :exhibition
  belongs_to :room
  belongs_to :exhibition_type

  has_many :artist_exhibits
  has_many :artists, through: :artist_exhibits

  validates :name, presence: true, length: { maximum: 255 }
  validates :width, :height, :depth, :weight, presence: true, numericality: { greater_than: 0 }
  validates :creation_date, presence: true
  validate :fits_in_room
  validate :creation_date_not_in_future

  private

  def fits_in_room
    return unless room && width && height && depth

    if width > room.width || height > room.height || depth > room.depth
      errors.add(:base, "Exhibit dimensions must not exceed room dimensions")
    end
  end

  def creation_date_not_in_future
    if creation_date.present? && creation_date > Date.current
      errors.add(:creation_date, "cannot be in the future")
    end
  end
end
