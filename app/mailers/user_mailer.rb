class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.follow_up_email.subject
  #
  def follow_up_email(email)
    mail(
        to: email,
        subject: 'We hope you are enjoying our app!'
    )
  end
end
