class ExhibitionType < ApplicationRecord
  has_many :exhibitions
  has_many :exhibits

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
