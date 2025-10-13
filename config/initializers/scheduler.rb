require 'rufus-scheduler'

return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == 'rake'

scheduler = Rufus::Scheduler.new

scheduler.cron '0 9 * * *' do
  Rails.logger.info "Running ExhibitionNotifierJob at #{Time.current}"
  ExhibitionNotifierJob.perform_later
end

Rails.logger.info "Rufus Scheduler started with #{scheduler.jobs.size} job(s)"