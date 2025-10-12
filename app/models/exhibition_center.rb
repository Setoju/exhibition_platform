class ExhibitionCenter < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :exhibitions, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :opening_hours, presence: true
  validates :contact_phone, presence: true, format: { with: /\A\+?\d{1,4}?\s?\(?\d{1,4}?\)?[\s.-]?\d{1,4}[\s.-]?\d{1,9}\z/ }
  validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
