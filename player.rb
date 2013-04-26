class Player
  def initialize
    @dying_health  = 8
    @severe_health = 13
    @max_health    = 20
    @last_health   = 20
    @direction     = :forward
    @retreating    = false
  end

  def play_turn(warrior)
    setup warrior

    next_action = pick_action
    until next_action[-1] == "!"
      update next_action
      next_action = pick_action
    end

    perform next_action

    cleanup
  end


  private
    attr_reader :w, :dying_health, :max_health, :last_health, :severe_health, :direction

    def setup warrior
      @w = warrior
      @healable = true
    end

    def cleanup
      @last_health = w.health
    end

    def pick_action
      if retreating?
        if taking_damage?
          :walk!
        elsif not injured?
          :end_retreat
        else
          heal
        end
      elsif feel.enemy?
        :attack!
      elsif feel.empty?
        if severe? and healable?
          heal
        elsif dying? and not healable?
          :begin_retreat
        else
          :walk!
        end
      elsif feel.captive?
        :rescue!
      elsif feel.wall?
        :pivot!
      end
    end

    def update action
      case action
      when :not_healable
        @healable = false
      when :turn_around
        turn
      when :begin_retreat
        turn
        @retreating = true
      when :end_retreat
        turn
        @retreating = false
      end
    end

    def retreating?
      @retreating
    end

    def feel
      w.feel direction
    end

    def turn
      if direction == :forward
        @direction = :backward
      else
        @direction = :forward
      end
    end

    def perform action, dir=direction
      if %i[walk! attack! rescue!].include? action
        w.send action, dir
      else
        w.send action
      end
    end

    def dying?
      w.health < dying_health
    end

    def injured?
      w.health < max_health
    end

    def severe?
      w.health < severe_health
    end

    def heal
      (injured? and not taking_damage?) ? :rest! : :not_healable
    end

    def healable?
      @healable
    end

    def taking_damage?
      w.health < last_health
    end
end
