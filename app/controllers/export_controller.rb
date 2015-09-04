class ExportController < ApplicationController
  before_action :authenticate_user!

  def index
    @members = Member.all
  end

end
