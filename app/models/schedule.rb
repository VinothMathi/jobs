class Schedule < ApplicationRecord
  has_and_belongs_to_many :events
  has_many :delayed_jobs
  has_many :jobs_logs
  belongs_to :user
  belongs_to :last_updated_by, class_name: 'User'
  scope :active, ->{where(status: 'active')}

  validates_presence_of :cron_schedule, :queue, :priority, :status
  validate :validate_cron_schedule

  before_create do |schedule|
    schedule.status = 'active'
    schedule.job = get_job
  end

  def validate_cron_schedule
    begin
      CrontabParser::Record.new(self.cron_schedule).should_run?(Time.now)
    rescue RuntimeError => e
      self.errors.add(:base, 'Cron schedule is not valid')
      true
    end
  end

  def active?
    self.status == 'active'
  end

  def self.invoke_jobs
    schedules = Schedule.active.sort_by(&:priority).select do |schedule|
      schedule.run_now?
    end
    schedules.each do |schedule|
      job_options = {schedule_id: schedule.id}
      job_options[:priority] = (schedule.priority.present? ? schedule.priority : 0)
      job_options[:queue] = (schedule.queue.present? ? schedule.queue : 'default')
      schedule.delay(job_options).invoke_job
    end
  end

  def insert_into_dj(options = {})
    options.merge!({schedule_id: self.id})
    self.delay(options).invoke_job
  end

  def invoke_job
    eval(self.job)
  end

  def run_now?
    return true
    CrontabParser::Record.new(self.cron_schedule).should_run?(Time.now)
  end

  def self.log_time_format(time=Time.now)
    time.strftime('%Y:%m:%d_%H:%M:%S')
  end

  def log_time_format(time=Time.now)
    self.class.log_time_format(time)
  end

  def self.logger
    @logger ||= new_logger
  end

  def self.new_logger
    Logger.new(File.join(Rails.root, 'log', 'scheduler.log'))
  end

  def toggle_status
    if self.active?
      self.status = 'inactive'
    else
      self.status = 'active'
    end
    self.save
  end

  private
  def get_job
    list_of_jobs = self.class.list_of_jobs
    list_of_jobs[rand(list_of_jobs.size)]
  end

  def self.list_of_jobs
    @list_of_jobs ||= begin
      jobs_list = []
      10.times do
        fk = Faker::Superhero
        jobs_list << "Rails.logger.info '#{fk.name} has superpower: #{fk.power}'"
      end
      jobs_list
    end
  end
end