class Player
  MAX_HEALTH   = 20
  DYING_HEALTH = 10

  def initialize
    @last_health = MAX_HEALTH
  end

  def play_turn(warrior)
    @state = 13
    @w = warrior
    next_action =  Array pick

    until next_action.first.to_s.end_with? '!'
      update next_action
      next_action = Array pick
    end

    perform next_action
    @last_health = @w.health
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
    when 7
      :rest!
    when 8
      %i[walk! backward]
    when 9
      %i[feel backward]
    when 10
      :health
    when 11
      :health
    when 12
      :rescue!
    when 13
      :feel
    end
  end

  def update action
    value = perform action
    case @state
    when 2
      @state = value.empty? ? 1 : 3
    when 4
      @state = injured?(value) ? 6 : 2
    when 5
      @state = value.empty? ? 4 : 3
    when 9
      @state = value.wall? ? 7 : 8
    when 10
      @state = dying?(value) ? 9 : 11
    when 11
      @state = taking_damage?(value) ? 2 : 5
    when 13
      @state = value.captive? ? 12 : 10
    end
  end

  def perform action
    if action.length > 1
      @w.send action.first, action[1]
    else
      @w.send action.first
    end
  end

  def injured? health
    health < MAX_HEALTH
  end

  def dying? health
    health < DYING_HEALTH
  end

  def taking_damage? health
    health < @last_health
  end
end
