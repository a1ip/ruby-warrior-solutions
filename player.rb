class Player
  def initialize
    @dying_health = 8
    @severe_health = 13
    @max_health   = 20
    @last_health  = 20
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
    attr_reader :w, :dying_health, :max_health, :last_health, :severe_health

    def setup warrior
      @w = warrior
      @healable = true
    end

    def cleanup
      @last_health = w.health
    end

    def pick_action
      if w.feel.enemy?
        :attack!
      elsif w.feel.empty?
        if severe? and healable?
          heal
        else
          :walk!
        end
      elsif w.feel.captive?
        :rescue!
      end
    end

    def update action
      case action
      when :not_healable
        @healable = false
      end
    end

    def perform action
      w.send action
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
