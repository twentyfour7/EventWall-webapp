# frozen_string_literal: true

# EventWall search controller
class EventWall < Sinatra::Base
  extend Econfig::Shortcut

  post '/search/?' do
    result = SearchEvents.call(params)

    if result.success?
      @search_result = result.value
      puts result.value
      flash[:notice] = "Here's what we have for "
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :event
  end
end
