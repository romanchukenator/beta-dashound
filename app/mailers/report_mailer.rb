class ReportMailer < ActionMailer::Base
  default from: 'rahul@getdashound.com'

  def self.call(user, reports = nil)
    report_mail = welcome(user, reports)
    report_mail.deliver
  end

  def welcome(user, reports)
    @user = user
    @url  = 'http://beta.getdashound.com'
    @reports = Hash.new

    @reports[:profit_loss] = reports[:file_pl].tempfile
    @reports[:balance_sheet] = reports[:file_bs].tempfile
    @reports[:cash_flow] = reports[:file_cf].tempfile

    attachments['profitLoss.csv'] = File.read(@reports[:profit_loss])
    attachments['balanceSheet.csv'] = File.read(@reports[:balance_sheet])
    attachments['cashFlow.csv'] = File.read(@reports[:cash_flow])

    mail(to: @user.email, subject: 'You got Dashound. Sweet.')
  end

  def reports(user, reports)
    @user = user
    @url  = 'http://beta.getdashound.com'
    @reports = Hash.new

    @reports[:profit_loss] = reports[:file_pl].tempfile
    @reports[:balance_sheet] = reports[:file_bs].tempfile
    @reports[:cash_flow] = reports[:file_cf].tempfile

    attachments['profitLoss.csv'] = File.read(@reports[:profit_loss])
    attachments['balanceSheet.csv'] = File.read(@reports[:balance_sheet])
    attachments['cashFlow.csv'] = File.read(@reports[:cash_flow])

    mail(to: "rahul@getdashound.com", 
        from: @user.email, 
        subject: 'Yo, @user.email from @user.company wants you to rip through these reports!')
  end
end