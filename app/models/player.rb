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

  def self.initial_victim_id_assignment
    self.all.each do |player|
      if player.id < self.all.size
        player.update_attribute(:victim_id, player.id + 1)
      else
        player.update_attribute(:victim_id, 1)
      end
    end
  end

  def victim_name
    Player(victim_id).name
  end

  def initial_victim_id_assignment
    if self.id < Player.all.size
      self.update_attribute(:victim_id, self.id + 1)
    else
      self.update_attribute(:victim_id, 1)
    end
  end

  def reassign_victim_upon_successful_assassination
    victim_id = victim.victim_id
  end

  def assassin
    Player.find(:victim_id, self.id)
  end

  def dies
    assassin.reassign_victim_upon_successful_assassination
    self.update_attribute(:alive?, false)
    #send assassin new e-mail
  end

end
