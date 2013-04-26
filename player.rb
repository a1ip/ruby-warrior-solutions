class Player
  def play_turn(warrior)
    @w = warrior

    if warrior.feel.enemy?
      w.attack!
    else
      w.walk!
    end
  end

  private
    attr_reader :w
end
