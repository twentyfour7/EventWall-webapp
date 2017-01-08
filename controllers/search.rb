# frozen_string_literal: true

# EventWall search controller
class EventWall < Sinatra::Base
  extend Econfig::Shortcut

  post '/search/?' do
    result = SearchEvents.call(params)

    if result.success?
      event_search_result = result.value
      @search_result = EventCardView.new(event_search_result)
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :events
  end
end