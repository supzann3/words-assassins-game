require 'gmail'
class Email #<<ActiveRecord::Base # not sure if we should create a table for email
 # belongs_to :player

    def initialize
      keys = YAML.load_file('keys.yml')
      @gmail = Gmail.connect(keys['EMAIL'], keys['PASSWORD'])
    end

    def deliver_gmail(recipient, subject, body)
      @gmail.deliver do
        # binding.pry email=Mail.new
        to "#{recipient}"
        subject "#{subject}"
        text_part do
          body "#{body}"
        end
        # html_part do
        #  content_type 'text/html; charset=UTF-8'
        #  body "<p>Text of <em>html</em> message.</p>" # add html part
      #  end
        # add_file "/path/to/some_image.jpg" add image
      end
    end


  def initial_email(player_email,word,victim) #comes from Player
    # players_email.each do |player| #either to a iteration at Player's class or pass an array here
      recipient = player_email
      subject = "Your secret mission."
      body = "You have been assigned to kill #{victim}. \n You can accomplish this by getting your victim to say the word #{word}"
      deliver_gmail(recipient, subject, body)
      puts "Sent e-mail to #{player_email}."
    # end
  end

  def reassigning_email(player_email,word,victim) #comes from Player
      recipient = player_email
      subject = "Your new victim"
      body = "You have a new victim to kill #{victim}. \n You can accomplish this by getting your victim to say the word #{word}"
      deliver_gmail(recipient, subject, body)
      puts "Sent e-mail to #{player_email}."
  end

  def dead_email(player_email,killer_name) #comes from Player
    recipient = player_email
    subject = "Your have been killed"
    body = "You have been killed by #{killer_name}, better luck next time. \n Thank you for playing !"
    deliver_gmail(recipient, subject, body)
    puts "Sent e-mail to #{player_email}."
  end

  def winner_email(player_email,winner_name) #comes from Player
    recipient = player_email
    subject = "The winner has been announced"
    body = "The winner of the game is #{winner_name}"
    deliver_gmail(recipient, subject, body)
    puts "Sent e-mail to #{player_email}."
  end
end