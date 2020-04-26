class UserMailer < ApplicationMailer
  
  default from: '778699870@qq.com'

  def welcome_email(file_url, email_address)
    Rails.logger.info "----------------"
    Rails.logger.info file_url
    Rails.logger.info "----------------"
    @file_url = file_url
    mail(to: email_address, subject: 'Go to link to download you file.')
  end
end