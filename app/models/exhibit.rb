class Exhibit < ApplicationRecord
  belongs_to :exhibition
  belongs_to :room
  belongs_to :exhibition_type

  has_many :artist_exhibits, dependent: :destroy
  has_many :artists, through: :artist_exhibits

  has_many_attached :photos

  attr_accessor :artist_name, :artist_biography, :artist_contact_email, :artist_contact_phone

  validates :name, presence: true, length: { maximum: 255 }
  validates :width, :height, :depth, :weight, presence: true, numericality: { greater_than: 0 }
  validates :creation_date, presence: true
  validates :artist_name, presence: true
  validate :fits_in_room
  validate :creation_date_not_in_future
  validate :exhibition_type_must_match

  after_save :create_or_find_artist

  private

  def create_or_find_artist
    return if artist_name.blank?
    
    artist = Artist.find_or_create_by(name: artist_name.strip)
    artist.update(
      biography: artist_biography,
      contact_email: artist_contact_email,
      contact_phone: artist_contact_phone
    ) if artist && (artist_biography.present? || artist_contact_email.present? || artist_contact_phone.present?)
    
    artist_exhibits.find_or_create_by(artist: artist)
  end

  def fits_in_room
    return unless room && width && height && depth

    if width > room.width || height > room.height || depth > room.depth
      errors.add(:base, "Exhibit dimensions must not exceed room dimensions")
      return
    end

    room_volume = room.width * room.height * room.depth
    existing_exhibits = room.exhibits.where.not(id: id)
    used_volume = existing_exhibits.sum { |e| e.width * e.height * e.depth }
    total_volume = used_volume + (width * height * depth)

    if total_volume > room_volume
      errors.add(:base, "Room cannot fit more exhibits: total exhibit volume exceeds room volume")
    end
  end

  def creation_date_not_in_future
    if creation_date.present? && creation_date > Date.current
      errors.add(:creation_date, "cannot be in the future")
    end
  end

  def exhibition_type_must_match
    if exhibition_type_id != exhibition&.exhibition_type_id
      errors.add(:exhibition_type_id, "must match exhibition type")
    end
  end
end
