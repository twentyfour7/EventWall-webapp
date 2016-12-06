# frozen_string_literal: true

# Gets list of all groups from API
class SearchEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :call_api_to_load_event
      step :return_api_result
    end.call(params)
  end

  register :call_api_to_load_event, lambda { |params|
    search = URI.escape(params['search'], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")) if params.include? 'search'
    begin
      uri = "#{EventWall.config.KKTIX_EVENT_API}/event/"
      uri += "?search=#{search}" unless search.nil?
      Right(HTTP.get(uri))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |result|
    data = result.body

    print result.status
    if result.status == 200
      events = result.parse
      Right(EventsSearchResultsRepresenter.new(Events.new).from_json(events.to_json))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
