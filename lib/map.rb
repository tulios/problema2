class Map
  
  def initialize file_content
    file_content.split("\n").each_with_index do |line, index|
      
      case index
        when 0 then initialize_size line
        when 1 then initialize_robot line
        else @robot.move!(line) if @robot
      end
      
    end
  end
  
  def robot_position
    @robot.position if @robot
  end
  
  def out_of_boundaries? x, y, orientation = nil
    case orientation
      when "N" then y+1 > @y
      when "E" then x+1 > @x
      when "S" then y-1 < 1
      when "W" then x-1 < 1
      else x > @x or y > @y
    end
  end
  
  private
  def initialize_size line
    raise "Line: 1: Wrong format!" unless line =~ /^\d+\s\d+$/
    @x, @y = line.split(/\s/).map {|str| str.to_i}
  end
  
  def initialize_robot line
    raise "Line: 2: Wrong format!" unless line =~ /^\d+\s\d+\s(E|W|N|S)$/
    params = line.split(/\s/)
    x, y = params[0].to_i, params[1].to_i
    
    raise "Line: 2: The map starts in 1, 1" if x == 0 or y == 0
    @robot = Robot.new x, y, params[2], self
  end
  
end