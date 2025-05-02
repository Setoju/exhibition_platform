class Exhibition < ApplicationRecord
  belongs_to :exhibition_center
  belongs_to :room
  belongs_to :exhibition_type
  has_many :exhibits
  has_many :tickets

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :dates_not_in_past

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after start date") if end_date < start_date
  end

  def dates_not_in_past
    if start_date.present? && start_date < Date.current
      errors.add(:start_date, "cannot be in the past")
    end
  end
end
