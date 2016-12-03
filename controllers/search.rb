# frozen_string_literal: true

# EventWall search controller
class EventWall < Sinatra::Base
  extend Econfig::Shortcut

  post '/search/?' do
    result = SearchEvents.call(params)

    if result.success?
      @search_result = result.value
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :event
  end
end
