class Robot
  
  attr_reader :x, :y, :orientation, :map
  
  @@compass = {
    "N+R" => "E",
    "E+R" => "S",
    "S+R" => "W",
    "W+R" => "N",
    
    "N+L" => "W",
    "W+L" => "S",
    "S+L" => "E",
    "E+L" => "N"
  }
  
  def initialize x, y, orientation, map
    @x, @y, @orientation, @map = x, y, orientation, map
  end
  
  def move! step
    raise "wrong step!" unless step =~ /^(L|R|M)+$/ or step =~ /^T\s\d+\s\d+$/
    if step =~ /^T\s\d+\s\d+$/
      params = step.gsub(/T\s/, '').split(/\s/)
      teleport params[0].to_i, params[1].to_i
      
    else
      
      step.scan(/(\w)/).flatten.each do |movement|
        change movement
      end
      
    end
  end
  
  private
  
  def change movement
    @orientation = @@compass["#{@orientation}+#{movement}"] if movement =~ /(L|R)/
    case @orientation
    when "E" then @x += 1
    when "W" then @x -= 1
    when "S" then @y -= 1
    when "N" then @y += 1
    end if movement =~ /M/
  end
  
  def teleport x, y
    raise "Trying to teleport to outside the boundaries" unless x <= @map.x and y <= @map.y
    @x, @y = x, y
  end
  
end