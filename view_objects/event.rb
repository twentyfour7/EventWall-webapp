# frozen_string_literal: true

EventView = Struct.new(
  :id,
  :title,
  :organization_id,
  :summary,
  :datetime,
  :location,
  :url,
  :event_type
)
