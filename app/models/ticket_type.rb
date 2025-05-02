class TicketType < ApplicationRecord
  belongs_to :tickets

  validates :type_name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end
