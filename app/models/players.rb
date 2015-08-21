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

  def victim_id
    id < Player.all.size ? id + 1 : 1
  end

  def reassign_victim_upon_successful_assassination
    victim_id = victim.victim_id
  end

  def victim_name
    Player(victim_id).name
  end

end
