class Player
  def initialize
  end

  def play_turn(warrior)
    if warrior.methods.include? :feel
      warrior_position = warrior.feel.instance_eval("@floor.units.detect{|el| el.is_a? RubyWarrior::Units::Warrior}").position
      warrior.feel.instance_eval("@floor").instance_eval("@stairs_location = [#{warrior_position.instance_eval("@x")}, #{warrior_position.instance_eval("@y")}]")
    else
      warrior.walk!
    end
  end
end
