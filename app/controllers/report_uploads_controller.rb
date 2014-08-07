class ReportUploadsController < ApplicationController

  def index
  end

  def create
    user = User.first
    ReportMailer.call(user, params[:report_uploads])
    redirect_to :root
  end

  def send_reports
    user = User.first
    ReportMailer.call(user, params[:report_uploads])
    redirect_to :root
  end
  
end