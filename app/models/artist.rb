class Artist < ApplicationRecord
  has_many :artist_exhibits
  has_many :exhibits, through: :artist_exhibits

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
