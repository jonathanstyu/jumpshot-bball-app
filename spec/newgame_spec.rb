describe 'new game controller' do 
  tests NewgameViewController
  
  before do
    jon = Player.create(:player_name => "Jon")
    jen = Player.create(:player_name => "Jenny")
    paul = Player.create(:player_name => "Paul")
    matt = Player.create(:player_name => "Matt")
  end
  
  it 'sets up the roster, with teams 1,2' do
    controller.instance_variable_get("@players").empty?.should == false    
  end
  
  it 'sets up team 1 right' do
    controller.instance_variable_get("@players")[1].empty?.should == true  
  end

  it 'sets up team 2 right' do
    controller.instance_variable_get("@players")[2].empty?.should == true  
  end  
  
  it 'goes to edit mode' do
    tap 'Assign Teams'
    controller.instance_variable_get("@player_viewer").editing.should == true  
  end
  
end