# frozen_string_literal: true

# Get event detail through event id
class GetEventDetail
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :call_api_to_get_event
      step :return_api_result
    end.call(params)
  end

  register :call_api_to_get_event, lambda { |params|
    event_id = params[:event_id]
    begin
      uri = "#{EventWall.config.KKTIX_EVENT_API}/event/detail/"
      uri += event_id
      puts uri
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
      Right(EventRepresenter.new(Event.new).from_json(events.to_json))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
