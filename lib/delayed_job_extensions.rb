require "delayed_job"
require "delayed/backend/active_record"
class Delayed::Backend::ActiveRecord::Job
  before_destroy do |job|
    begin
      jl = JobsLog.create(job.attributes)
      Rails.logger.info jl.inspect
      Rails.logger.info jl.errors.to_a.inspect
    rescue => e
      Rails.logger.info e.message.inspect
      Rails.logger.info e.backtrace.join('\n')
      Rails.logger.info job.id.inspect
    end
  end
end