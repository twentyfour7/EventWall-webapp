# frozen_string_literal: true

# Gets list of all groups from API
class SearchEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(search_keyword)
    Dry.Transaction(container: self) do
      step :call_api_to_load_event
      step :return_api_result
    end.call(url_request)
  end

  register :call_api_to_load_event, lambda { |kktix_org_slug|
    begin
      Right(HTTP.post("#{EventWall.config.kktix_event_api}/org",
                      json: { kktix_org_slug: kktix_org_slug }))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |result|
    data = http_result.body.to_s
    if http_result.status == 200
      Right(EventRepresenter.new(Event.new).from_json(data))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
