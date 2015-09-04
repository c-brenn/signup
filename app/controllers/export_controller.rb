class ExportController < ApplicationController
  before_action :authenticate_user!

  def index
    @members = Member.all
    respond_to do |format|
      format.html
      format.csv { send_data @members.to_csv }
    end
  end

end
