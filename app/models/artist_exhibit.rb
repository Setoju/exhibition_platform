class ArtistExhibit < ApplicationRecord
  belongs_to :artist
  belongs_to :exhibit

  validates :artist_id, presence: true
  validates :exhibit_id, presence: true
  validates :artist_id, uniqueness: { scope: :exhibit_id, message: "already associated with this exhibit" }
end
