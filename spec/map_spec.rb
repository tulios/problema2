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
  
end