class ReportUploadsController < ApplicationController

  def create
    user = current_user
    ReportMailer.call(user, params[:report_uploads])
    redirect_to current_user
  end
end