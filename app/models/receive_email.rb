class ReceiveEmail < ActiveRecord::Base
  belongs_to :player

    @@keys = YAML.load_file('keys.yml')
    @@gmail = Gmail.connect(@@keys['EMAIL'], @@keys['PASSWORD'])

  def self.check_email
    @@gmail.inbox.all.each do |email|
      # binding.pry
      re = ReceiveEmail.new
      sender = (Player.find_by email: email.message.from)

      if !!sender
        re.subject = email.subject
        re.player_id = sender.id
        sender.dies if re.contains_dead_words?
        sender.victim.send_death_notice if re.contains_victory_words?
      end

    end
  end

  def contains_dead_words?
    !!(subject.downcase.include?("dead") || subject.downcase.include?("killed") || subject.downcase.include?("quit"))
  end

  def contains_victory_words?
    !!(subject.downcase.include?("victorious") || subject.downcase.include?("win") || subject.downcase.include?("vanquish") || subject.downcase.include?("won"))
  end
end
