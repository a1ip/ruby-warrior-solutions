class Player
  def play_turn(warrior)
    @state = 1
    @w = warrior
    next_action = pick

    until next_action.to_s.end_with? '!'
      next_action = pick
    end

    perform next_action
  end

  def pick
    case @state
    when 1
      :walk!
    end
  end

  def perform action
    @w.send action
  end
end
