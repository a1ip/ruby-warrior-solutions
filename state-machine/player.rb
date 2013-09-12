class Player
  def play_turn(warrior)
    @state = 2
    @w = warrior
    next_action = pick

    until next_action.to_s.end_with? '!'
      update next_action
      next_action = pick
    end

    perform next_action
  end

  def pick
    case @state
    when 1
      :walk!
    when 2
      :feel
    when 3
      :attack!
    end
  end

  def update action
    value = perform action
    case @state
    when 2
      @state = value.empty? ? 1 : 3
    end
  end

  def perform action
    @w.send action
  end
end
