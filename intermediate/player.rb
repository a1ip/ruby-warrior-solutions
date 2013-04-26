class Player
  def play_turn(warrior)
    setup warrior

    next_action = pick_action
    until next_action[-1] == "!"
      update next_action
      next_action = pick_action
    end
    perform next_action
  end

  private
    attr_reader :w

    def setup warrior
      @w = warrior
    end

    def pick_action
      if feel.enemy?
        :attack!
      else
        :walk!
      end
    end

    def perform action, dir=stairs?
      if %i[walk! attack!].include? action
        w.send action, dir
      else
        w.send action
      end
    end

    def update action
    end

    def feel dir=stairs?
      w.feel dir
    end

    def walk_to_stairs
      w.walk!(stairs?)
    end

    def stairs?
      w.direction_of_stairs
    end

    def done?
      @done
    end
end
