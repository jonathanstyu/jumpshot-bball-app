class AddGameViewController < UIViewController
  include SugarCube::Modal 
  # The center view of the app
  
  def viewDidLoad
    super
    self.title = "Game Record"
    view.backgroundColor = :white.uicolor
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.titled('Add') {open_add_player}
  
    addGame 
    
    left_frame = CGRect.make(x: 0, y: 0, width: view.bounds.width * 0.6, height: view.bounds.height)
    right_frame = CGRect.make(x: left_frame.width, y: 0, width: view.bounds.width * 0.4, height: view.bounds.height)
    
    team1_name = UILabel.new
    team1_name.frame = CGRect.make(x: 0, y: 0, width: left_frame.width / 2, height: 25)
    team1_name.text = "Team 1"
    team1_name.backgroundColor = "noise_lines.png".uicolor
    team1_name.textAlignment = :center.uialignment
    team1_name.textColor = :black.uicolor
    team1_name.font = :bold.uifont(12)
    view << team1_name
    
    @team1_label = UILabel.new
    @team1_label.frame = team1_name.frame.below.height(60)
    @team1_label.text = "0"
    @team1_label.backgroundColor = :black.uicolor
    @team1_label.textAlignment = :center.uialignment
    @team1_label.textColor = :white.uicolor
    @team1_label.font = :bold.uifont(40)
    view << @team1_label
    
    team2_name = UILabel.new
    team2_name.frame = team1_name.frame.beside
    team2_name.text = "Team 2"
    team2_name.backgroundColor = team1_name.backgroundColor
    team2_name.textAlignment = team1_name.textAlignment
    team2_name.textColor = team1_name.textColor
    team2_name.font = team1_name.font
    view << team2_name
    
    @team2_label = UILabel.new
    @team2_label.frame = @team1_label.frame.beside
    @team2_label.text = "0"
    @team2_label.backgroundColor = @team1_label.backgroundColor
    @team2_label.textAlignment = @team1_label.textAlignment
    @team2_label.textColor = @team1_label.textColor
    @team2_label.font = @team1_label.font
    view << @team2_label
    
    # Panel for the action recording buttons 
    left_scroll = UIScrollView.new
    left_scroll.frame = CGRect.make(x: 0, y: @team1_label.frame.y + @team1_label.frame.height, width: left_frame.width, height: view.bounds.height)
    left_scroll.backgroundColor = "subtle_dots.png".uicolor
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
      playerButton.frame = [[20, 50*x],[right_frame.width * 0.6,40]]
      playerButton.setTitle("#{roster[x].player_name}", forState: UIControlStateNormal)
      playerButton.addTarget(self, action: "player_button_touched:", forControlEvents: UIControlEventTouchUpInside)
      playerButton.tag = x
      right_scroll << playerButton
    end
    
    # Adds the function buttons to track points and scored
    actions = ["Made FG", "Missed FG", "Rebound", "Assist"]
    @buttons = []
    
    made_fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    made_fg_button.frame = CGRect.make(x: 20, y: 25, width: (left_frame.width * 0.8), height: 35)
    made_fg_button.font = "Avenir-Black".uifont(18.0)
    made_fg_button.setTitle("Made FG", forState: UIControlStateNormal)
    made_fg_button.tag = 1
    made_fg_button.addTarget(self, action: "action_button_touched:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_fg_button 
    
    missed_fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    missed_fg_button.frame = made_fg_button.frame.below(20)
    missed_fg_button.font = "Avenir-Black".uifont(18.0)
    missed_fg_button.setTitle("Missed FG", forState: UIControlStateNormal)
    missed_fg_button.tag = 2
    missed_fg_button.addTarget(self, action: "action_button_touched:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_fg_button 
    
    made_3fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    made_3fg_button.frame = missed_fg_button.frame.below(20)
    made_3fg_button.font = "Avenir-Black".uifont(18.0)
    made_3fg_button.setTitle("Made 3FG", forState: UIControlStateNormal)
    made_3fg_button.tag = 5
    made_3fg_button.addTarget(self, action: "action_button_touched:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_3fg_button 
    
    rebound_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    rebound_button.frame = made_3fg_button.frame.below(20)
    rebound_button.font = "Avenir-Black".uifont(18.0)
    rebound_button.setTitle("Rebound", forState: UIControlStateNormal)
    rebound_button.tag = 3
    rebound_button.addTarget(self, action: "action_button_touched:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << rebound_button
    
    assist_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    assist_button.frame = rebound_button.frame.below(20)
    assist_button.font = "Avenir-Black".uifont(18.0)
    assist_button.setTitle("Assist", forState: UIControlStateNormal)
    assist_button.tag = 4
    assist_button.addTarget(self, action: "action_button_touched:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << assist_button
    
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
    @buttons.each {|button| button.enabled = true }
  end
  
  def action_button_touched(sender)
    @data_tag[:action] = sender.tag
    process_data
  end
  
  # Resets the menu, updates the labels 
  def process_data
    accessed_player = Player.all[@data_tag[:player]]
    if @data_tag[:action] == 1
      accessed_player.points += 2
    elsif @data_tag[:action] == 3
      accessed_player.rebounds += 1
    elsif @data_tag[:action] == 4
      accessed_player.assists += 1 
    elsif @data_tag[:action] == 5
      accessed_player.points += 3
    end
    @team1_label.text = "#{tally_points("Flying Meat")}"
    @team2_label.text = "#{tally_points("Falling Hippos")}"
    reset_menu
  end
  
  # Clears up the menu to prepare for the next number 
  def reset_menu
    @data_tag = {}
    @data_tag.clear
    @buttons.each {|button| button.enabled = false }
  end
  
  # Tallies up all the points on a team
  def tally_points(team_name)
    team = Team.where(:team_name).eq(team_name).first
    total = 0
    team.players.each do |player|
      total += player.points
    end
    return total
  end
  
  def open_add_player
    player_panel = AddPlayerViewController.new
    present_modal(UINavigationController.alloc.initWithRootViewController(player_panel))
  end
  
end
