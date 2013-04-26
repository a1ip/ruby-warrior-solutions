class Player
  def initialize
    @dying_health = 8
    @max_health   = 20
  end

  def play_turn(warrior)
    @w = warrior


    next_action = pick_action
    until next_action[-1] == "!"
      update next_action
      next_action = pick_action
    end

    perform next_action
  end


  private
    attr_reader :w, :dying_health, :max_health

    def pick_action
      if w.feel.enemy?
        :attack!
      elsif w.feel.empty?
        if dying?
          heal
        else
          :walk!
        end
      end
    end

    def update action
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

    def heal
      injured? ? :rest! : :none
    end
end
