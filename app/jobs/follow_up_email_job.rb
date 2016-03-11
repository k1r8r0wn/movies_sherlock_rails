class FollowUpEmailJob
  @queue = :follow_up_email_que

  def self.perform(email)
    UserMailer.follow_up_email(email).deliver_now
  end
end
