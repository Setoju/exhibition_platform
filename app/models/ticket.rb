class Ticket < ApplicationRecord
  belongs_to :exhibition
  has_one :ticket_type
  has_many :purchases

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
