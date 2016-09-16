# Preview all emails at http://localhost:3000/rails/mailers/club_mailer
class ClubMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/club_mailer/account_activation
  def account_activation
  	club = Club.first
  	club.activation_token = Club.new_token
    ClubMailer.account_activation(club)
  end

  # Preview this email at http://localhost:3000/rails/mailers/club_mailer/password_reset
  def password_reset
    club = Club.first
    club.reset_token = Club.new_token
    ClubMailer.password_reset(club)
  end

end
