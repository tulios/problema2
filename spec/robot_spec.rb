require 'spec_helper'

describe Robot do
  
  it 'should verify the step format' do
    lambda { Robot.new(1,1,'N', Map.new).move!("") }.should raise_error
    lambda { Robot.new(1,1,'N', Map.new).move!("A A A") }.should raise_error
    lambda { Robot.new(1,1,'N', Map.new).move!("LLRRMMMRLRMMM J") }.should raise_error
    lambda { Robot.new(1,1,'N', Map.new).move!("L L RRMMMRLRMMM") }.should raise_error
  end
  
  it 'should not teleport for out of bounds' do
    robot = Robot.new 1, 1, 'N', Map.new("2 2")
    robot.should_not be_nil
    lambda { robot.move!("T 3 2") }.should raise_error
    lambda { robot.move!("T 2 3") }.should raise_error
  end
  
  it 'should define x and y during teleport' do
    robot = Robot.new 1, 1, 'N', Map.new("2 2")
    robot.should_not be_nil
    robot.move!("T 2 2")
    robot.x.should eql 2
    robot.y.should eql 2
    robot.orientation.should eql "N"
  end
  
  context 'when changing the orientation' do
    
    it 'should change turning the left' do
      robot = Robot.new 1, 1, 'N', Map.new("2 2")
      robot.should_not be_nil
      robot.orientation.should eql "N"
      robot.move!("L")
      robot.orientation.should eql "W"
      robot.move!("L")
      robot.orientation.should eql "S"
      robot.move!("L")
      robot.orientation.should eql "E"
      robot.move!("L")
      robot.orientation.should eql "N"
    end
    
    it 'should change turning the right' do
      robot = Robot.new 1, 1, 'N', Map.new("2 2")
      robot.should_not be_nil
      robot.orientation.should eql "N"
      robot.move!("R")
      robot.orientation.should eql "E"
      robot.move!("R")
      robot.orientation.should eql "S"
      robot.move!("R")
      robot.orientation.should eql "W"
      robot.move!("R")
      robot.orientation.should eql "N"
    end
    
  end
  
  context 'when changing the position' do
    
    it 'should move from the left to the right' do
      robot = Robot.new 1, 1, 'E', Map.new("2 2")
      robot.should_not be_nil
      robot.move!("M")
      robot.x.should eql 2
      robot.y.should eql 1
    end
    
    it 'should move from the right to the left' do
      robot = Robot.new 2, 1, 'W', Map.new("2 2")
      robot.should_not be_nil
      robot.move!("M")
      robot.x.should eql 1
      robot.y.should eql 1
    end
    
    it 'should move from the top to the bottom' do
      robot = Robot.new 1, 2, 'S', Map.new("2 2")
      robot.should_not be_nil
      robot.move!("M")
      robot.x.should eql 1
      robot.y.should eql 1
    end
    
    it 'should move from the bottom to the top' do
      robot = Robot.new 1, 1, 'N', Map.new("2 2")
      robot.should_not be_nil
      robot.move!("M")
      robot.x.should eql 1
      robot.y.should eql 2
    end
    
  end
  
end





































