desc "Send out emails to test deliverability"
task :send_email_test => :environment do
  send_email_test
end

def send_email_test
  15.times do |i|
    count = i + 1
    recipients.each do |email|
      send_email(email, count)
      puts "#{count} of 15 to #{email}"
      sleep 5
    end
  end

end

def recipients
  ["jess@brownwebdesign.com", "BMills@thoriumllc.com", "jill.ramsburg@gmail.com"]
end

def send_email(email, count)
  ActionMailer::Base.mail(
    from: 'info@globalconsultantexchange.com',
    to: email,
    subject: "Email Test from Server (#{count} of 15)",
    body: "Email #{count} of 15 to test the server. Sent to #{email}")
    .deliver
end

