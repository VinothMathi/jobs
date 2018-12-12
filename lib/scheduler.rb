#!/usr/bin/env ruby

pwd = File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'daemons'

require File.join(pwd,'..','config','environment')
begin
  logger = Schedule.new_logger
  logger.info(Schedule.log_time_format + " PID:#{Process.pid} Scheduler Started..")

  loop do
    Schedule.invoke_jobs
    logger.info("Jobs count - #{Delayed::Job.count}")
    sleep(60 - Time.now.sec)                    #run every one minute
  end
ensure
  logger.info(Schedule.log_time_format + " PID:#{Process.pid} Scheduler Stopped..")
  logger.close
end