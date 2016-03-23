class SiteStatisticsEmailJob
  @queue = :site_statistics_email_que

  def self.perform
    UserMailer.site_statistics_email.deliver_now
  end
end
