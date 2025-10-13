class ExhibitionReminderMailer < ApplicationMailer
    def reminder_email(user, exhibition)
        @user = user
        @exhibition = exhibition
        @days_until_start = (@exhibition.start_date.to_date - Date.today).to_i

        mail(to: @user.email, subject: "Reminder: Upcoming Exhibition '#{@exhibition.name}'")
    end
end
