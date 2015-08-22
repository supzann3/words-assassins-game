require 'gmail'
require 'pry'

class Emails

  def initialize
    #add @email hash
    @words = ["apple", "punch", "slight", "done"]
    @players = ["Nancy Hawa", "Susan He"]
  end

  def assign_victim(player)
    # binding.pry
    if @players.index(player) < (@players.length - 1)
      @players.index(player) + 1
    else
      0
    end
  end

  def deliver_gmail(recipient, subject, body)
    gmail = Gmail.connect('word.assassins@gmail.com', 'susanandnancy')
    gmail.deliver do
      # binding.pry email=Mail.new
      to "#{recipient}"
      # binding.pry
      subject "#{subject}"
      text_part do
        # binding.pry
        body "#{body}"
      end
    end
  end

  def send_email
    @players.each do |player|
      recipient = @email_hash[player]
      subject = "Your secret mission."
      body = "You have been assigned to kill #{@players[assign_victim(player)]}. \n You can accomplish this by getting your victim to say the word #{@words[rand(0..@words.length-1)]}"
      deliver_gmail(recipient, subject, body)
      puts "Sent e-mail to #{player}."
    end
  end

end
