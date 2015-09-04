class MembersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def add_members
    members ||= params[:members]
    if members && members.kind_of?(Array)
      render json:{ results: Member.import_json(members) }
    else
      render nothing: true, status: :unprocessable_entity
    end
  end
end
