class SchedulesController < ApplicationController
  before_action :require_login
  before_action :load_schedule, only: [:show, :update, :edit, :toggle_status]

  def new
    @schedule = Schedule.new
  end

  def index
    @schedules = Schedule.all.includes(:user, :last_updated_by)
  end

  def edit
    render :new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user = Current.user
    @schedule.last_updated_by = Current.user
    if @schedule.save
      flash[:success] = 'Schedule created successfully'
      redirect_to schedule_path(@schedule)
    else
      flash[:error] = @schedule.errors.full_messages
      redirect_back(fallback_location: schedules_path)
    end
  end

  def update
    @schedule.attributes = schedule_params
    @schedule.last_updated_by = Current.user
    if @schedule.save
      flash[:success] = 'Schedule updated successfully'
      redirect_to schedule_path(@schedule)
    else
      flash[:error] = @schedule.errors.full_messages
      redirect_back(fallback_location: schedules_path)
    end
  end

  def toggle_status
    if @schedule.toggle_status
      flash[:success] = 'Schedule updated successfully'
      redirect_back(fallback_location: schedules_path)
    else
      flash[:error] = @schedule.errors.full_messages
      redirect_back(fallback_location: schedules_path)
    end
  end

  private
  def load_schedule
    @schedule = Schedule.find(params[:id].to_i)
  end

  def schedule_params
    params.require(:schedule).permit(:cron_schedule, :job, :queue, :priority, :status)
  end

  def redirect_to_default
    redirect_to schedules_path
  end
end