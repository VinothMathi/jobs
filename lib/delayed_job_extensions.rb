require "delayed_job"
require "delayed/backend/active_record"
class Delayed::Backend::ActiveRecord::Job
  before_destroy do |job|
    begin
      JobsLog.create(job.attributes)
    rescue => e
      Rails.logger.info e.message.inspect
      Rails.logger.info e.backtrace.join('\n')
      Rails.logger.info job.id.inspect
    end
  end
end