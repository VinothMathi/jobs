module Public
  module Api
    class EventsController < BaseController
      def trigger
        event_codes = Array.wrap(params[:events])
        if event_codes.present?
          events = Event.where(code: event_codes).active
          invalid_events = event_codes.map(&:to_s) - events.map(&:code)
          events.each do |event|
            event.schedules.each do |schedule|
              schedule.insert_into_dj(queue: 'event', run_at: Time.now, priority: 1, event_id: event.id)
            end
          end
          if invalid_events.any?
            render_error("These events are not present/active: #{invalid_events.join(', ')}")
          else
            render_success
          end
        else
          render_error("Please provide atleast one event")
        end
      end
    end
  end
end