# frozen_string_literal: true
require 'date'
require_relative 'event'

class EventDetailView

  attr_reader :events

  def initialize(event)
    # puts '>>event_card: ', search_result
    @events = format_all_events(event)
  end

  private

  def format_all_events(events)
    new_events = events&.map do |event|
      formatted_event(event)
    end
  end

  def formatted_event(event)
    event_date = DateTime.strptime(event.datetime.split(' ')[0], '%Y/%m/%d').to_date
    event_time = event.datetime.split(' ')[1]
    EventView.new(
      id = event.id,
      title = event.title,
      date = event_date,
      time = event_time,
      location = event.location,
      summary = event.summary,
      url = event.url
    )
  end
end
