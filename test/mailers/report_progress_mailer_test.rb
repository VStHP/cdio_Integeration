require 'test_helper'

class ReportProgressMailerTest < ActionMailer::TestCase
  test "report_subject" do
    mail = ReportProgressMailer.report_subject
    assert_equal "Report subject", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
