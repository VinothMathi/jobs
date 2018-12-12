class EventsController < ApplicationController
	before_action :require_login
  before_action :load_event, only: [:show, :toggle_status]

  def index
  	@events = Event.all.includes({schedules: [:user, :last_updated_by]})
  end

  def show
  end

  def toggle_status
  	if @event.toggle_status
      flash[:success] = 'Event updated successfully'
      redirect_back(fallback_location: events_path)
    else
      flash[:error] = @event.errors.full_messages
      redirect_back(fallback_location: events_path)
    end
  end

  private
  def load_event
  	@event = Event.find_by_id(params[:id].to_i)
  end
end