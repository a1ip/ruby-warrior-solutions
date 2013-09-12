class Player
  MAX_HEALTH = 20

  def play_turn(warrior)
    @state = 4
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
    when 4
      :health
    when 5
      :feel
    when 6
      :rest!
    end
  end

  def update action
    value = perform action
    case @state
    when 2
      @state = value.empty? ? 1 : 3
    when 4
      @state = injured?(value) ? 5 : 2
    when 5
      @state = value.empty? ? 6 : 3
    end
  end

  def perform action
    @w.send action
  end

  def injured? health
    health < MAX_HEALTH
  end
end
