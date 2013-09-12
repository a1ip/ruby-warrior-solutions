class Player
  MAX_HEALTH   = 20
  DYING_HEALTH = 9

  def initialize
    @last_health = MAX_HEALTH
  end

  def play_turn(warrior)
    @state = 7
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
      :look
    when 3
      :shoot!
    when 4
      :health
    when 5
      :feel
    when 6
      :rest!
    when 7
      %i[look backward]
    when 8
      %i[walk! backward]
    when 9
      :health
    when 10
      :health
    when 11
      :health
    when 12
      :rescue!
    when 13
      :feel
    when 14
      %i[feel backward]
    when 15
      %i[rescue! backward]
    when 16
      :feel
    when 17
      :pivot!
    when 18
      :look
    when 19
      :shoot!
    when 20
      %i[look backward]
    when 21
      %i[shoot! backward]
    when 22
      %i[feel backward]
    end
  end

  def update action
    value = perform action
    case @state
    when 2
      @state = enemy_first?(value) ? 3 : 1
    when 4
      @state = injured?(value) ? 6 : 2
    when 5
      @state = value.empty? ? 4 : 3
    when 6
      @state = stairs_first?(value) ? 1 : 7
    when 7
      @state = captive_first?(value) ? 22 : 20
    when 9
      @state = taking_damage?(value) ? 8 : 6
    when 10
      @state = dying?(value) ? 9 : 11
    when 11
      @state = taking_damage?(value) ? 2 : 5
    when 13
      @state = value.captive? ? 12 : 10
    when 14
      @state = value.captive? ? 15 : 13
    when 16
      @state = value.wall? ? 17 : 14
    when 18
      @state = wizard_first?(value) ? 19 : 16
    when 20
      @state = archer_first?(value) ? 21 : 18
    when 22
      @state = value.captive? ? 15 : 8
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

  def wizard_first? spaces
    spaces.select{|space| space.to_s != "nothing"}.first.to_s == "Wizard"
  end

  def archer_first? spaces
    spaces.select{|space| space.to_s != "nothing"}.first.to_s == "Archer"
  end

  def captive_first? spaces
    spaces.select{|space| space.to_s != "nothing"}.first.to_s == "Captive"
  end

  def enemy_first? spaces
    !["", "Captive", "wall"].include? spaces.select{|space| space.to_s != "nothing"}.first.to_s
  end
end
