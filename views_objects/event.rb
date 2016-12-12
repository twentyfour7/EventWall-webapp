# frozen_string_literal: true

EventView = Struct.new(
  :id, :title, :date, :time, :location, :summary, :url
  # :event_type, :organization
)
