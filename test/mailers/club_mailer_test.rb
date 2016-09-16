require 'test_helper'

class ClubMailerTest < ActionMailer::TestCase
  
  test "account_activation" do 
    club = clubs(:kapow)
    club.activation_token = Club.new_token
    mail = ClubMailer.account_activation(club)
    assert_equal "Account activation", mail.subject
    assert_equal [club.email], mail.to
    assert_equal ["noreply@classmaster.com"], mail.from
    assert_match club.name, mail.body.encoded
    assert_match club.activation_token, mail.body.encoded
    assert_match CGI.escape(club.email), mail.body.encoded
  end

end
