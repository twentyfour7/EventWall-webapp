# frozen_string_literal: true

EventView = Struct.new(
  :id, :title, :date, :time, :location, :event_type, :summary, :url, :org_id, :org_name, :cover_img_url
)