# frozen_string_literal: true

# Gets list of all groups from API
class SearchEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(search_keyword)
    Dry.Transaction(container: self) do
      step :call_api_to_load_event
      step :return_api_result
    end.call(search_keyword)
  end

  register :call_api_to_load_event, lambda { |search_keyword|
    kktix_org_slug = search_keyword["search"]
    puts '>>search_events/call_api_to_load_event: ', kktix_org_slug
    puts "#{EventWall.config.kktix_event_api}"
    begin
      Right(HTTP.get("#{EventWall.config.kktix_event_api}/org/#{kktix_org_slug}/event"))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |result|
    puts '>>search_events/return_api_result'
    data = result.body
    puts '>>search_events/return_api_result: ', data

    if result.status == 200
      Right(
        data.each do |event|
          EventRepresenter.new(Event.new).from_json(event)
        end
      )
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
