class Player < ActiveRecord::Base
  has_many :receive_emails
 # include Word
 # def assign_victim_id
 #   x = self.id + 1
 #   loop do
 #     if Player(x % Player.all.size).alive? == TRUE
 #       return Player(x % Player.all.size).alive?
 #     end
 #     x += 1
 #     if x == Player.all.size
 #       id_looper = 1
 #     end
 #   end
 # end

 def dies
   victim.assign_word
   Email.new.reassigning_email(assassin.email, victim.word, victim.name)
   Email.new.dead_email(self.email, assassin.name)
   self.update_attribute(:alive?, false)
   assassin.increase_kills
   reassign_victim_upon_successful_assassination
   announce_winner if winner?
 end

 def increase_kills
   assassin.update_attribute(:kills, assassin.kills + 1)
 end

 def self.initial_victim_id_assignment
   self.all.each do |player|
     player.initial_victim_id_assignment
     player.update_attribute(:alive?, true)
     player.assign_word
   end
 end

 def victim
   Player.find_by id: victim_id
 end

 def assassin
   Player.find_by victim_id: id
 end

 def initial_victim_id_assignment
   continued_victim_pool? ? choose_next_victim : loop_to_find_victim
 end

 def self.first_email
   Player.all.each do |player|
     binding.pry
     Email.new.initial_email(player.email, player.victim.word, player.victim.name)
   end
 end


 def initial_victim_id_assignment_mg
   #for this to work, we need a game_players table.  The ids will be game player ids.
   #The following methods would need to be changed.
    #1.  continued_victim_pool?
    #2.  initial_victim_id_assignment
    #3.  choose_next_victim
    #4.  loop_to_find_victim
 end

 def self.assign_words
   Player.all.each do |player|
     assign_word
   end
 end

 def assign_word
  update_attribute(:word, Word.word_list.sample)
 end

 def continued_victim_pool?
   !!(self.id < Player.all.size)
 end

 def loop_to_find_victim
   self.update_attribute(:victim_id, 1)
 end

 def choose_next_victim
   self.update_attribute(:victim_id, self.id + 1)
 end

 # def initial_victim_id_assignment
 #   if self.id < Player.all.size
 #     self.update_attribute(:victim_id, self.id + 1)
 #   else
 #     self.update_attribute(:victim_id, 1)
 #   end
 #   #Email.initial_email(name,players_email,words)
 # end

 def reassign_victim_upon_successful_assassination
   assassin.update_attribute(:victim_id, self.victim_id)
   self.update_attribute(:victim_id, nil)
 end

 def winner?
   !!(Player.where(alive?: true).size == 1)
 end

 def announce_winner
   winner = Player.find_by(alive?: true).name
   Player.all.each do |player|
     Email.new.winner_email(player.email, winner)
   end
 end


end
