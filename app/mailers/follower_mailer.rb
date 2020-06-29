class FollowerMailer < ApplicationMailer

# Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.club_mailer.account_activation.subject
  #
  def follower_alert
    mail to: "rhys@attendrr.com", subject: "New follower!"
  end

end
