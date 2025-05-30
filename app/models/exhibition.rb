class Exhibition < ApplicationRecord
  belongs_to :exhibition_center
  belongs_to :room
  belongs_to :exhibition_type
  has_many :exhibits, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourited_by, through: :favourites, source: :user

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :dates_not_in_past
  validate :no_time_collision_in_room

  def status
    if end_date < Date.current
      'Finished'
    elsif start_date > Date.current
      'Upcoming'
    else
      'Ongoing'
    end
  end

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

  def no_time_collision_in_room
    return unless room_id.present? && start_date.present? && end_date.present?
    
    overlapping_exhibitions = room.exhibitions
      .where.not(id: id)
      .where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date >= ? AND end_date <= ?)',
        end_date, end_date,
        start_date, start_date,
        start_date, end_date)
    
    if overlapping_exhibitions.exists?
      errors.add(:base, 'There is already an exhibition scheduled in this room during the selected dates')
    end
  end
end
