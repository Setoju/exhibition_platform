class Artist < ApplicationRecord
    has_many :artist_exhibits
    has_many :exhibits, through: :artist_exhibits
  
    validates :name, presence: true
    validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
  