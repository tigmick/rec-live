class ApplicationMailer < ActionMailer::Base
  default from: "fredtig60@gmail.com"
  layout 'mailer'

  def email_with_name(email, name)
    %("#{name}" <#{email}>)
  end 
end
