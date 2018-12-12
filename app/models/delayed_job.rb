class DelayedJob < ApplicationRecord
  belongs_to :schedule

  def self.invoke_jobs
    jobs = Job.where("run_at < now()").sort_by(&:priority).select do |job|
      job.run_now?
    end
    jobs.each do |job|
      job.invoke_job
    end
  end
end