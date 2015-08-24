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
        re.update_attribute(:player_id, sid)
      end
      email.read!
      email.archive!
    end
  end

  def email_contains_dead_words?
    !!(subject.include?("dead") || subject.include?("killed") || subject.include?("quit"))
  end

  def kill_victim
    if email_contains_dead_words
        Player.find(player_id).update_attribute(:alive?, false)
    end
  end

end
