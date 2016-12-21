# frozen_string_literal: true

# Get organization detail through org id
class GetOrgDetail
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :call_api_to_get_org
      step :return_api_result
    end.call(params)
  end

  register :call_api_to_get_org, lambda { |params|
    org_id = params[:org_id]
    begin
      uri = "#{EventWall.config.KKTIX_EVENT_API}/org/detail/"
      uri += org_id
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
      org = result.parse
      Right(OrganizationRepresenter.new(Organization.new).from_json(org.to_json))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
