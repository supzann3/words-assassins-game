class ReceiveEmail < ActiveRecord::Base
  belongs_to :player

    @@keys = YAML.load_file('keys.yml')
    @@gmail = Gmail.connect(@@keys['EMAIL'], @@keys['PASSWORD'])

  def self.check_email

    @@gmail.inbox.all.each do |email|
      re = ReceiveEmail.new

      sender = (Player.find_by email: email.message.from)

      if !!sender
        sid = sender.id
        re.update_attribute(:subject, email.subject)
        re.update_attribute(:sender_id, sid)
      end
      email.read!
      email.archive!
    end
  end
end
