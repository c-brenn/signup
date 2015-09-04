class AccessController < ApplicationController
  before_action :authenticate

  def index
    if t = ApiKey.create
      render json: { token: t.access_token }
    else
      render nothing: true, status: :not_acceptable
    end
  end

private

  def authenticate
    authenticate_or_request_with_http_basic do |email, password|
      resource = User.find_by(email: email)
      if resource.valid_password?(password)
        sign_in :user, resource
      end
    end
    warden.custom_failure! if performed?
  end
end
