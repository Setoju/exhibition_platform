class ExhibitionNotifierJob < ApplicationJob
  queue_as :default

  def perform
    target_date = 3.days.from_now.to_date

    exhibitions_starting_soon = Exhibition.where(
      start_date: target_date.all_day
    ).includes(:favourited_by)

    exhibitions_starting_soon.each do |exhibition|
      exhibition.favourited_by.find_each do |user|
        ExhibitionReminderMailer.reminder_email(user, exhibition).deliver_later
      end
    end
  end
end
