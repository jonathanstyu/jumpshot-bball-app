class AddGameViewController < UIViewController
  include SugarCube::Modal 
  # The center view of the app
  
  def viewDidLoad
    super
    self.title = "Game Record"
    view.backgroundColor = :black.uicolor
    addGame
    layout_views
    reset_menu
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end
  
  def viewDidAppear(animated)
    @player_table.reloadData
  end
  
  def layout_views
    left_frame = CGRect.make(x: 0, y: 0, width: view.bounds.width * 0.6, height: view.bounds.height)
    right_frame = CGRect.make(x: left_frame.width, y: 0, width: view.bounds.width * 0.4, height: view.bounds.height)
    
    team1_name = UILabel.new
    team1_name.frame = CGRect.make(x: 0, y: 0, width: left_frame.width / 2, height: 25)
    team1_name.text = "Team 1"
    team1_name.backgroundColor = "subtle_dots.png".uicolor
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
    left_scroll.contentSize = CGSizeMake(left_frame.width, left_frame.height * 1.5)
    left_scroll.pagingEnabled = true
    
    player_header = UILabel.new
    player_header.frame = CGRect.make(x: left_frame.width, y: 0, width: right_frame.width, height: 25)  
    player_header.backgroundColor = :black.uicolor
    player_header.text = "Add Players"
    player_header.textAlignment = :center.uialignment
    player_header.textColor = :white.uicolor
    player_header.font = :bold.uifont(12)
    view << player_header
    
    button_tray = UIView.new
    button_tray.frame = player_header.frame.below.height(60)
    view << button_tray
    
    add_player_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    add_player_button.frame = CGRect.make(x: 0, y:0, width: button_tray.frame.width, height: 45)
    add_player_button.setBackgroundImage("add_player.png".uiimage, forState: UIControlStateNormal)
    add_player_button.addTarget(self, action: "open_add_player", forControlEvents: UIControlEventTouchUpInside)
    button_tray << add_player_button
  
    view << left_scroll
    
    @player_table = UITableView.new
    @player_table.frame = CGRect.make(x: left_frame.width, y: 85, width: right_frame.width, height: view.bounds.height - 50)
    @player_table.backgroundColor = :clear.uicolor
    @player_table.separatorColor = :white.uicolor
    @player_table.dataSource = @player_table.delegate = self 
    view << @player_table
    
    # Adds the function buttons to track points and scored
    @buttons = []
    
    made_fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    made_fg_button.frame = CGRect.make(x: 20, y: 25, width: (left_frame.width * 0.8), height: 35)
    made_fg_button.font = "Avenir-Black".uifont(18.0)
    made_fg_button.setTitle("Made FG", forState: UIControlStateNormal)
    made_fg_button.tag = 1
    made_fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_fg_button 
    
    missed_fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    missed_fg_button.frame = made_fg_button.frame.below(20)
    missed_fg_button.font = "Avenir-Black".uifont(18.0)
    missed_fg_button.setTitle("Missed FG", forState: UIControlStateNormal)
    missed_fg_button.tag = 2
    missed_fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_fg_button 
    
    made_3fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    made_3fg_button.frame = missed_fg_button.frame.below(20)
    made_3fg_button.font = "Avenir-Black".uifont(18.0)
    made_3fg_button.setTitle("Made 3FG", forState: UIControlStateNormal)
    made_3fg_button.tag = 5
    made_3fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_3fg_button 

    missed_3fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    missed_3fg_button.frame = made_3fg_button.frame.below(20)
    missed_3fg_button.font = "Avenir-Black".uifont(18.0)
    missed_3fg_button.setTitle("Missed 3FG", forState: UIControlStateNormal)
    missed_3fg_button.tag = 8
    missed_3fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_3fg_button
    
    rebound_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    rebound_button.frame = missed_3fg_button.frame.below(20)
    rebound_button.font = "Avenir-Black".uifont(18.0)
    rebound_button.setTitle("Rebound", forState: UIControlStateNormal)
    rebound_button.tag = 3
    rebound_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << rebound_button
    
    assist_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    assist_button.frame = rebound_button.frame.below(20)
    assist_button.font = "Avenir-Black".uifont(18.0)
    assist_button.setTitle("Assist", forState: UIControlStateNormal)
    assist_button.tag = 4
    assist_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << assist_button
    
    steal_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    steal_button.frame = assist_button.frame.below(20)
    steal_button.font = "Avenir-Black".uifont(18.0)
    steal_button.setTitle("Steal", forState: UIControlStateNormal)
    steal_button.tag = 6
    steal_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << steal_button
    
    block_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    block_button.frame = steal_button.frame.below(20)
    block_button.font = "Avenir-Black".uifont(18.0)
    block_button.setTitle("Block", forState: UIControlStateNormal)
    block_button.tag = 7
    block_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << block_button
    
    # Adds the flat pill button that triggers the Full Stat View Controller 
    full_stat_button = FlatPillButton.new 
    full_stat_button.frame = block_button.frame.below(60).taller(10).wider(15).left(10)
    full_stat_button.font = "Avenir-Black".uifont(20)
    full_stat_button.setTitle("Full Box Score", forState: UIControlStateNormal)
    full_stat_button.setTitleColor(0xff0000.uicolor, forState:UIControlStateNormal)
    full_stat_button.addTarget(self, action: "open_stat_controller", forControlEvents: UIControlEventTouchUpInside)
    left_scroll << full_stat_button
    
    # Adds the button to the scroll 
    @buttons.each {|button| 
       left_scroll << button }
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  # For the player picking Table
  def tableView(tableView, numberOfRowsInSection: section)
    @players_team1 = Player.where(:team).eq(1).all
    @players_team2 = Player.where(:team).eq(2).all
    if section == 0
      return @players_team1.count
    else
      return @players_team2.count
    end
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell
    end
    if indexPath.section == 0      
      cell.text = @players_team1[indexPath.row].player_name
      cell.textColor = :white.uicolor
      cell.font = "Avenir-Black".uifont(16)
    else
      cell.text = @players_team2[indexPath.row].player_name
      cell.textColor = :white.uicolor
      cell.font = "Avenir-Black".uifont(16)
    end
    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if indexPath.section == 0
      @data_tag[:player] = @players_team1[indexPath.row]
    else
      @data_tag[:player] = @players_team2[indexPath.row]
    end
    @buttons.each {|button| button.enabled = true }
  end
  
  # weird implementation of the tableview function
  def numberOfSectionsInTableView(tableView)
    2
  end
  
  def tableView(tableView, titleForHeaderInSection: section)
    if section == 0 
      return "Team 1"
    else 
      return "Team 2"
    end
  end
  
  # Helper functions that help record games 
  def addGame
    Player.create(:player_name => "Jon", :team => 1)
    Player.create(:player_name => "Paul", :team => 1)
    Player.create(:player_name => "Rick", :team => 2)
    Player.create(:player_name => "Carl", :team => 2)
  end
  
  # Resets the menu, updates the labels 
  def process_data(sender)
    action_tag = sender.tag 
    accessed_player = @data_tag[:player]
    if action_tag == 1
      accessed_player.points += 2
      accessed_player.total_field_goals += 1
      accessed_player.made_field_goals += 1
    elsif action_tag == 3
      accessed_player.rebounds += 1
    elsif action_tag == 4
      accessed_player.assists += 1 
    elsif action_tag == 5
      accessed_player.points += 3
      accessed_player.total_field_goals += 1
      accessed_player.made_field_goals += 1
    elsif action_tag == 2
      accessed_player.total_field_goals += 1
    elsif action_tag == 6
      accessed_player.steals += 1
    elsif action_tag == 7
      accessed_player.blocks += 1
    elsif action_tag == 8
      accessed_player.total_field_goals += 1
    end
    @team1_label.text = "#{tally_points(1)}"
    @team2_label.text = "#{tally_points(2)}"
    reset_menu
  end
  
  # Clears up the menu to prepare for the next number 
  def reset_menu
    @data_tag = {}
    @buttons.each {|button| button.enabled = false }
  end
  
  # Tallies up all the points on a team
  def tally_points(team_name)
    players_on_team = Player.where(:team).eq(team_name).all
    total = 0
    players_on_team.each do |player|
      total += player.points
    end
    return total
  end
  
  def open_add_player
    player_panel = AddPlayerViewController.new
    present_modal(UINavigationController.alloc.initWithRootViewController(player_panel))
  end
  
  def open_stat_controller
    stat_panel = FullStatViewController.new
    present_modal(UINavigationController.alloc.initWithRootViewController(stat_panel))
  end
  
end
