require 'spec_helper'

describe Map do
  
  describe 'when initializing the size' do
    
    it 'should verify the line format' do
      lambda { Map.new "A B\n" }.should raise_error
      lambda { Map.new "A B A A\n" }.should raise_error
      lambda { Map.new "1 2 3\n" }.should raise_error
      lambda { Map.new "1 B\n" }.should raise_error
    end

    it 'should fill x and y' do
      map = Map.new "1 1\n"
      map.instance_variable_get(:@x).should eql 1
      map.instance_variable_get(:@y).should eql 1
    end
    
  end
  
  describe 'when initializing the robot' do
    
    it 'should verify the line format' do
      lambda { Map.new "1 1\nA A A\n" }.should raise_error
      lambda { Map.new "1 1\n1 1 1\n" }.should raise_error
      lambda { Map.new "1 1\nA 1 A\n" }.should raise_error
      lambda { Map.new "1 1\n1 2 3 4\n" }.should raise_error
    end
    
    it 'should fill robot' do
      Map.new("1 1\n1 1 E\n").instance_variable_get(:@robot).should_not be_nil
      Map.new("1 1\n1 1 W\n").instance_variable_get(:@robot).should_not be_nil
      Map.new("1 1\n1 1 N\n").instance_variable_get(:@robot).should_not be_nil
      Map.new("1 1\n1 1 S\n").instance_variable_get(:@robot).should_not be_nil
    end
    
  end
  
  it 'should detect a movement out of the bounds' do
    map = Map.new("1 1")
    map.out_of_boundaries?(1, 1, 'N').should be_true
    map.out_of_boundaries?(1, 1, 'E').should be_true
    map.out_of_boundaries?(1, 1, 'S').should be_true
    map.out_of_boundaries?(1, 1, 'W').should be_true
  end
  
  it 'should detect a movement inside the bounds' do
    map = Map.new("2 2")
    map.out_of_boundaries?(1, 1, 'N').should be_false
    map.out_of_boundaries?(1, 2, 'E').should be_false
    map.out_of_boundaries?(2, 2, 'S').should be_false
    map.out_of_boundaries?(2, 1, 'W').should be_false
  end
  
end































