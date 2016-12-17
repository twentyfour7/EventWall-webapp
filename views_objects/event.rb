# frozen_string_literal: true

EventView = Struct.new(
  :id, :title, :date, :time, :location, :summary, :url, :org_id, :org_name
  # :event_type, 
)
