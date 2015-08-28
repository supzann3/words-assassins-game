class Player < ActiveRecord::Base
  has_many :receive_emails

 def dies
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
   Email.new.initial_email(self.email, victim.word, victim.name)
 end

 def self.word_assignment
   Player.all.each do |player|
     player.update_attribute(:word, Word.word_list.shuffle[0])
   end
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
