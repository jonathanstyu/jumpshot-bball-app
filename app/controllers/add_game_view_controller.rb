class AddGameViewController < UIViewController
  # The center view of the app
  
  def viewDidLoad
    super
    self.title = "Add Game"
    view.backgroundColor = "noise_lines.png".uicolor
    
    # @add = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    # @add.frame = [[0,0],[100,100]]
    # @add.setTitle("Add",forState:UIControlStateNormal)
    # @add.sizeToFit
    # @add.addTarget(self, action: "addGame", forControlEvents: UIControlEventTouchUpInside)
    # view << @add 
    addGame 
    
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def addGame
    team1 = Team.create(:team_name => "Flying Meat", :number_of_players => 3)
    team2 = Team.create(:team_name => "Falling Hippos", :number_of_players => 3)
    team1.players.create(:player_name => "Jon")
    team1.players.create(:player_name => "Matt")
    team1.players.create(:player_name => "Paul")
    team2.players.create(:player_name => "Pharaoh")
    team2.players.create(:player_name => "Zorro")
    team2.players.create(:player_name => "Carl")
  end
  
end
