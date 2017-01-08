# frozen_string_literal: true
require 'date'
require_relative 'event_card'

# event card view
class EventCardView
  MAX_TITLE_LEN = 22
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
    new_events = new_events.select { |event| event.date > Date.today.to_date-15 }
    new_events = new_events.sort_by(&:date).reverse
    new_events = new_events[0..19]
    new_events
  end

  def formatted_event(event) # :event_title, :date, :time, :location, :event_type
    event_id = event.id
    # event_title = shortened(event.title, MAX_TITLE_LEN)
    event_title = event.title
    # event_date = event.datetime.split(' ')[0]
    puts event_title
    puts event.datetime
    event_date = Date.parse(event.datetime&.split(' ')[0]).to_date
    event_time = "08:00"
    event_time = event.datetime&.split(' ')[1] if event.datetime&.split(' ')[1]
    event_location = "國立清華大學"
    event_location = shortened(event.location.split('/')[0], MAX_LOC_LEN) if event.location
    cover_img_url = nil
    cover_img_url = event.cover_img_url if event.respond_to? 'cover_img_url'
    EventView.new(
      id = event_id,
      title = event_title,
      date = event_date,
      time = event_time,
      location = event_location,
      event_type = event.event_type,
      cover_img_url = cover_img_url
    )
  end

  def shortened(str, size)
    return nil unless str
    str.length < size ? str : str[0..size] + '...'
  end
end
