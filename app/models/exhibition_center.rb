class ExhibitionCenter < ApplicationRecord
  has_many :rooms
  has_many :exhibitions
  
  validates :name, presence: true
  validates :address, presence: true
  validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
