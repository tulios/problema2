class Robot
  
  attr_reader :x, :y, :orientation
  
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
    raise "Wrong step! (#{step})" unless step =~ /^(L|R|M)+$/ or step =~ /^T\s\d+\s\d+$/
    if step =~ /^T\s\d+\s\d+$/
      params = step.gsub(/T\s/, '').split(/\s/)
      teleport params[0].to_i, params[1].to_i
      
    else
      step.scan(/(\w)/).flatten.each {|side_or_movement| change_or_walk side_or_movement}
    end
  end
  
  def position
    "#{@x} #{@y} #{@orientation}"
  end
  
  private
  
  def change_or_walk side_or_movement
    if side_or_movement =~ /(L|R)/
      @orientation = @@compass["#{@orientation}+#{side_or_movement}"] 
    
    else
      raise "Out of boundaries!" if @map.out_of_boundaries?(@x, @y, @orientation)
      case @orientation
        when "E" then @x += 1
        when "W" then @x -= 1
        when "S" then @y -= 1
        when "N" then @y += 1
      end
      
    end 
  end
  
  def teleport x, y
    raise "Trying to teleport to outside the boundaries" if @map.out_of_boundaries?(x, y)
    @x, @y = x, y
  end
  
end