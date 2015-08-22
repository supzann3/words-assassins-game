class Player < ActiveRecord::Base

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

  def initial_victim_id_assignment
    continued_victim_pool? ? choose_next_victim : loop_to_find_victim
    Email.new.initial_email(self.email, victim.word, victim.name)
  end

  def dies
    assassin.reassign_victim_upon_successful_assassination
    self.update_attribute(:alive?, false)
    Email.new.reassigning_email(assassin.email, victim.name victim.word)
    Email.new.dead_email(self.email, assassin.name)
  end

  def continued_victim_pool?
    self.id < Player.all.size
  end

  def self.initial_victim_id_assignment
    self.all.each do |player|
      if player.id < self.all.size
        player.update_attribute(:victim_id, player.id + 1)
      else
        player.update_attribute(:victim_id, 1)
      end
    end
  end

  def victim
    Player(victim_id)
  end

  def loop_to_find_victim
    self.update_attribute(:victim_id, self.id + 1)
  end

  def choose_next_victim
    self.update_attribute(:victim_id, 1)
  end

  def reassign_victim_upon_successful_assassination
    victim_id = victim.victim_id
  end

  def assassin
    Player.find(:victim_id, self.id)
  end



end
