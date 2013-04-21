class AddGameViewController < UIViewController
  # The center view of the app
  
  def viewDidLoad
    super
    self.title = "Add Game"
    view.backgroundColor = UIColor.whiteColor
    
    @add = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add.frame = [[0,0],[100,100]]
    @add.setTitle("Add",forState:UIControlStateNormal)
    @add.sizeToFit
    @add.addTarget(self, action: "addGame", forControlEvents: UIControlEventTouchUpInside)
    view << @add 
    
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def addGame
    game1 = Game.create(:team1 => "The Pigeons", :team2 => "The Cats")
    game1.players.create(:player_name => "Jenny")
    game1.players.create(:player_name => "Libby")
    puts game1.players.count
  end
  
end
