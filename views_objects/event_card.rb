# frozen_string_literal: true
require 'date'
require_relative 'event_card'

class EventCardView
  MAX_TITLE_LEN = 20
  MAX_LOC_LEN = 25

  attr_reader :events

  def initialize(search_result)
    # puts '>>event_card: ', search_result
    @events = format_all_events(search_result.events)
  end

  private

  def format_all_events(events)
    new_events = events&.map do |event|
      formatted_event(event)
    end
    # new_events = new_events.select { |event| event.date > DateTime.now.to_date }
    new_events = new_events.sort_by { |event| event.date }.reverse
  end

  def formatted_event(event) # :event_title, :date, :time, :location, :event_type
    event_id = event.id
    event_title = shortened(event.title, MAX_TITLE_LEN)
    # event_date = event.datetime.split(' ')[0]
    # @item.rigged ? "Yes" : "No" 
    event_date = event.datetime.nil? ? '' : DateTime.strptime(event.datetime.split(' ')[0].sub('/', '-'), '%Y-%m-%d').to_date
    event_time = event.datetime.nil? ? '' : event.datetime.split(' ')[1]
    event_location = event.location.nil? ? '' : shortened(event.location.split('/')[0], MAX_LOC_LEN)
    EventView.new(
      id = event_id,
      title = event_title,
      date = event_date,
      time = event_time,
      location = event_location,
      event_type = event.event_type
    )
  end

  def shortened(str, size)
    return nil unless str
    str.length < size ? str : str[0..size] + '...'
  end
end
