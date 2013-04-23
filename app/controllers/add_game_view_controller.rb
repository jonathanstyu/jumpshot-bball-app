class AddGameViewController < UIViewController
  # The center view of the app
  
  def viewDidLoad
    super
    self.title = "Add Game"
    view.backgroundColor = :white.uicolor
    # @add = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    # @add.frame = [[0,0],[100,100]]
    # @add.setTitle("Add",forState:UIControlStateNormal)
    # @add.sizeToFit
    # @add.addTarget(self, action: "addGame", forControlEvents: UIControlEventTouchUpInside)
    # view << @add 
    addGame 
    
    
    left_frame = CGRect.make(x: 0, y: 0, width: view.bounds.width * 0.6, height: view.bounds.height)
    left_scroll = UIScrollView.alloc.initWithFrame left_frame
    left_scroll.backgroundColor = "noise_lines.png".uicolor
    left_scroll.contentSize = CGSizeMake(left_frame.width, left_frame.height * 2)
    left_scroll.pagingEnabled = true
    
    right_frame = CGRect.make(x: left_frame.width, y: 0, width: view.bounds.width * 0.4, height: view.bounds.height)
    label = UILabel.alloc.initWithFrame right_frame.height(45)
    label.font = UIFont.boldSystemFontOfSize(20)
    label.backgroundColor = :clear.uicolor
    label.textAlignment = :center.uialignment 
    label.textColor = :black.uicolor 
    label.text = "Players"
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin
    view << label
    
    right_scroll = UIScrollView.alloc.initWithFrame label.frame.below.height(view.bounds.height)
    right_scroll.backgroundColor = :clear.uicolor
    right_scroll.contentSize = CGSizeMake(right_frame.width, right_frame.height * 2)
  
    view << left_scroll
    view << right_scroll
    
    # adds the player buttons 
    roster = Player.all 
      
    roster.each_index do |x|
      playerButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      playerButton.frame = [[20, 100*x],[right_frame.width * 0.6,50]]
      playerButton.setTitle("#{roster[x].player_name}", forState: UIControlStateNormal)
      playerButton.addTarget(self, action: "nothing", forControlEvents: UIControlEventTouchUpInside)
      right_scroll << playerButton
    end
    
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
