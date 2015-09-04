class MembersController < ApplicationController
  before_action :authenticate
  protect_from_forgery only: []

  def add_members
    members ||= params[:members]
    if members && members.kind_of?(Array)
      render json:{ results: Member.import_json(members) }
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end
end
