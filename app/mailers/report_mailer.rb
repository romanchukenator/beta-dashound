class ReportMailer < ActionMailer::Base
  default from: "rahul@getdashound.com"
  default to: "rahul@getdashound.com"

  def self.call(user, reports = nil)
    welcome_mail = welcome(user)
    report_mail = reports(user, reports)
    
    welcome_mail.deliver
    report_mail.deliver
  end

  def welcome(user)
    @user = user
    @url  = "http://beta.getdashound.com"

    mail(to: "#{@user.email}", 
        subject: "Your benchmarks are coming soon, no worries.")
  end

  def reports(user, reports)
    @user = user
    @url  = "http://beta.getdashound.com"
    @reports = Hash.new
    @company_name = reports["company_name"]

    @reports[:profit_loss] = reports[:file_pl].tempfile
    @reports[:balance_sheet] = reports[:file_bs].tempfile
    @reports[:cash_flow] = reports[:file_cf].tempfile

    attachments["profitLoss.csv"] = File.read(@reports[:profit_loss])
    attachments["balanceSheet.csv"] = File.read(@reports[:balance_sheet])
    attachments["cashFlow.csv"] = File.read(@reports[:cash_flow])

    mail(from: @user.email, 
        subject: "Yo, dude at #{@user.email} wants you to rip through these reports for #{@company_name}!")
  end
end