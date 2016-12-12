# frozen_string_literal: true

# EventWall evnet controller
class EventWall < Sinatra::Base

  get '/event/:event_id' do
    slim :event_detail
  end
end
