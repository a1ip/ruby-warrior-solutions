class Player
  def play_turn(warrior)
    setup warrior

    walk_to_stairs
  end

  private
    attr_reader :w

    def setup warrior
      @w = warrior
    end

    def walk_to_stairs
      w.walk!(w.direction_of_stairs)
    end
end
