class Game

  def scramble_players(array)
    #I am picturing that we will normalize this data so that we have an array of hashes, each with one key and one value {"player name" => "player e-mail"}
    array.shuffle
  end

  def create_players(array)
    array.each do |player|
      player.each do |name, email|
        Player.create(name: name, email: email)
      end
    end
  end

end
