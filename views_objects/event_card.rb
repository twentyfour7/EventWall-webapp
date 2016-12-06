# frozen_string_literal: true
require_relative 'event'

class EventCardView
  MAX_TITLE_LEN = 22
  MAX_LOC_LEN = 25

  attr_reader :events

  def initialize(search_result)
    puts '>>event_card: ', search_result
    @events = format_all_events(search_result.events)
  end

  private

  def format_all_events(events)
    new_events = events&.map do |event|
      formatted_event(event)
    end
  end

  def formatted_event(event) # :event_title, :date, :time, :location, :event_type
    event_title = shortened(event.title, MAX_TITLE_LEN)
    event_date = event.datetime.split(' ')[0]
    event_time = event.datetime.split(' ')[1]
    event_location = shortened(event.location.split('/')[0], MAX_LOC_LEN)
    puts event_title, event_date, event_time, event_location
    EventView.new(
      title = event_title,
      date = event_date,
      time = event_time,
      location = event_location
    )
  end

  def shortened(str, size)
    return nil unless str
    str.length < size ? str : str[0..size] + '...'
  end
end
