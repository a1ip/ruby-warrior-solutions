class Player
  def initialize
  end

  def play_turn(warrior)
    warrior_position = warrior.feel.instance_eval("@floor.units.detect{|el| el.is_a? RubyWarrior::Units::Warrior}").position
    x = warrior_position.instance_eval("@x")
    y = warrior_position.instance_eval("@y")
    warrior.feel.instance_eval("@floor").instance_eval("@stairs_location = [#{x}, #{y}]")
  end
end
