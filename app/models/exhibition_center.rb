class ExhibitionCenter < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :exhibitions, dependent: :destroy
  
  validates :name, presence: true
  validates :address, presence: true
  validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
