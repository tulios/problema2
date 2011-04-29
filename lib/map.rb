class Map
  
  attr_reader :x, :y
  
  def initialize file_content
    file_content.split("\n").each_with_index do |line, index|
      
      case index
      when 0 then initialize_size line
      when 1 then initialize_robot line
      else
        @robot.move!(line) if @robot
      end
      
    end
                     
    puts "#{@robot.x} #{@robot.y} #{@robot.orientation}" if @robot
  end
  
  private
  def initialize_size line
    raise "Line: 1: Wrong format!" unless line =~ /^\d+\s\d+$/
    @x, @y = line.split(/\s/).map {|str| str.to_i}
  end
  
  def initialize_robot line
    raise "Line: 2: Wrong format!" unless line =~ /^\d+\s\d+\s(E|W|N|S)$/
    params = line.split(/\s/)
    @robot = Robot.new params[0].to_i, params[1].to_i, params[2], self
  end
  
end