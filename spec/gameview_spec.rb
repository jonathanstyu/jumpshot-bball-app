describe 'Game View Controller' do 
  tests GameViewController
  before do
    jon = Player.create(:player_name => "Jon")
    jen = Player.create(:player_name => "Jenny")
    game = Game.create(:date_played => Time.new, :team_1 => [jon], :team_2 => [jen])
    initWithGame(game)
  end
  
  it 'set up current_game' do
    controller.instance_variable_get("current_game").should.equal game
  end
  
  it 'sets up team 1 right' do
    controller.instance_variable_get("@players_team1").first.should == jon
  end

  it 'sets up team 2 right' do
    controller.instance_variable_get("@players_team2").first.should == jen  
  end  
  
  
end