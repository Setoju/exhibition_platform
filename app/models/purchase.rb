class Purchase < ApplicationRecord
  belongs_to :ticket

  validates :customer_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :customer_email, presence: true, 
            format: { with: URI::MailTo::EMAIL_REGEXP },
            length: { maximum: 255 }
  validates :purchase_date, :purchase_time, presence: true
  validate :purchase_date_not_in_future
  validate :ticket_still_valid

  private

  def purchase_date_not_in_future
    if purchase_date.present? && purchase_date > Date.current
      errors.add(:purchase_date, "cannot be in the future")
    end
  end

  def ticket_still_valid
    if ticket && ticket.exhibition
      if ticket.exhibition.start_date < Date.current
        errors.add(:base, "Cannot purchase tickets for past exhibitions")
      end
    end
  end
end
