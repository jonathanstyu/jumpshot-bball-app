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
    right_frame = CGRect.make(x: left_frame.width, y: 0, width: view.bounds.width * 0.4, height: view.bounds.height)
    
    team1_label = UILabel.new
    team1_label.frame = CGRect.make(x: 0, y: 0, width: left_frame.width / 2, height: 45)
    team1_label.text = "#{tally_points('Flying Meat')}"
    team1_label.backgroundColor = "noise_lines.png".uicolor
    team1_label.textAlignment = :center.uialignment
    team1_label.textColor = 0x417a71.uicolor
    team1_label.font = :bold.uifont(27)
    view << team1_label
    
    team2_label = UILabel.new
    team2_label.frame = team1_label.frame.beside
    team2_label.text = "#{tally_points('Falling Hippos')}"
    team2_label.backgroundColor = team1_label.backgroundColor
    team2_label.textAlignment = team1_label.textAlignment
    team2_label.textColor = team1_label.textColor
    team2_label.font = team1_label.font
    view << team2_label
    
    left_scroll = UIScrollView.new
    left_scroll.frame = CGRect.make(x: 0, y: team1_label.frame.y + team1_label.frame.height, width: left_frame.width, height: view.bounds.height)
    left_scroll.backgroundColor = "noise_lines.png".uicolor
    left_scroll.contentSize = CGSizeMake(left_frame.width, left_frame.height * 2)
    left_scroll.pagingEnabled = true
    
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
      playerButton.frame = [[20, 75*x],[right_frame.width * 0.6,50]]
      playerButton.setTitle("#{roster[x].player_name}", forState: UIControlStateNormal)
      playerButton.addTarget(self, action: "player_button_touched:", forControlEvents: UIControlEventTouchUpInside)
      playerButton.tag = x
      right_scroll << playerButton
    end
    
    # Adds the function buttons to track points and scored
    actions = ["Made FG", "Missed FG", "Rebound", "Assist"]
    @buttons = []
    
    # actions.each_index do |x|
    #   actionButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    #   actionButton.frame = [[20, 100*x],[left_frame.width * 0.6,50]]
    #   actionButton.setTitle("#{actions[x]}", forState: UIControlStateNormal)
    #   actionButton.addTarget(self, action: "add_#{actions[x].downcase.tr(' ', '_')}", forControlEvents: UIControlEventTouchUpInside)
    #   @buttons << actionButton
    # end
    # 
    
    made_fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    made_fg_button.frame = CGRect.make(x: 0, y: 0, width: left_frame.width/2, height: 100)
    made_fg_button.setTitle("Made FG", forState: UIControlStateNormal)
    made_fg_button.tag = 1
    made_fg_button.addTarget(self, action: "action_button_touched:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_fg_button 
    
    @buttons.each {|button| 
       left_scroll << button }
    
    reset_menu
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
  
  def player_button_touched(sender)
    @data_tag[:player] = sender.tag
    puts @data_tag[:player]
    @buttons.each {|button| button.enabled = true }
    puts @data_tag
  end
  
  def action_button_touched(sender)
    puts sender.tag
    @data_tag[:action] = sender.tag
    process_data
    puts @data_tag
  end
  
  def process_data
    accessed_player = Player.all[@data_tag[:player]]
    if @data_tag[:action] == 1
      accessed_player.points += 2
    end
    puts @data_tag
    reset_menu
  end
  
  def reset_menu
    @data_tag = {}
    @data_tag.clear
    @buttons.each {|button| button.enabled = false }
  end
  
  def tally_points(team_name)
    team = Team.where(:team_name).eq(team_name).first
    total = 0
    team.players.each do |player|
      total += player.points
    end
    return total
  end
  
end
