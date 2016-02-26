class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = 'localhost:3000'
  default from: 'movies_sherlock@example.com'
end
