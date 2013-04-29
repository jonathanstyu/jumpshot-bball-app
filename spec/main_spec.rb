describe "Application 'bball'" do
  before do
    @app = UIApplication.sharedApplication
    jon = Player.create(:player_name => "Jon")
    jen = Player.create(:player_name => "Jenny")
    paul = Player.create(:player_name => "Paul")
    matt = Player.create(:player_name => "Matt")
    game = Game.create(:date_played => Time.new, :team_1 => [jon, paul], :team_2 => [jen, matt])
  end
  
  it "creates a player" do 
    Player.all.empty?.should == false
  end
  
  it "creates a game" do 
    Game.all.empty?.should == false
  end
end
