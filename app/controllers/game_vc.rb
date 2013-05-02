class GameViewController < UIViewController
  include SugarCube::Modal 
  attr_accessor :current_game
  
  def viewDidLoad
    super
    self.title = "Game"
    view.backgroundColor = :black.uicolor
    layout_views
    reset_menu
  end
  
  def initWithGame(game)
    initWithNibName(nil, bundle:nil)
    self.current_game = game
    @players_teams = current_game.create_index
    self
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
    
    if Device.ipad?
      score_font = :bold.uifont(60)
      label_font = :bold.uifont(17)
      button_cell_height = (left_frame.height * 0.05)      
    else
      score_font = :bold.uifont(35)
      label_font = :bold.uifont(12)
      button_cell_height = (left_frame.height * 0.1)      
    end
    
    
    team1_name = UILabel.new
    team1_name.frame = CGRect.make(x: 0, y: 0, width: left_frame.width / 2, height: left_frame.height * 0.05 )
    team1_name.text = "Team 1"
    team1_name.backgroundColor = "subtle_dots.png".uicolor
    team1_name.textAlignment = :center.uialignment
    team1_name.textColor = :black.uicolor
    team1_name.font = label_font
    view << team1_name
    
    @team1_label = UILabel.new
    @team1_label.frame = team1_name.frame.below.height(left_frame.height * 0.1)
    @team1_label.text = "0"
    @team1_label.backgroundColor = :black.uicolor
    @team1_label.textAlignment = :center.uialignment
    @team1_label.textColor = :white.uicolor
    @team1_label.font = score_font
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
    left_scroll.frame = CGRect.make(x: 0, y: @team1_label.frame.y + @team1_label.frame.height, width: left_frame.width, height: view.bounds.height - @team1_label.frame.y)
    left_scroll.backgroundColor = "subtle_dots.png".uicolor
    left_scroll.contentSize = CGSizeMake(left_frame.width, left_frame.height * 1.5)
    left_scroll.pagingEnabled = true
  
    view << left_scroll
    
    @player_table = UITableView.new
    @player_table.frame = CGRect.make(x: left_frame.width, y: 0, width: right_frame.width, height: view.bounds.height - 50)
    @player_table.backgroundColor = :clear.uicolor
    @player_table.separatorColor = :white.uicolor
    @player_table.rowHeight = 100 if Device.ipad?
    @player_table.dataSource = @player_table.delegate = self 
    view << @player_table
    
    # Adds the function buttons to track points and scored
    @buttons = []
    
    made_fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    made_fg_button.frame = CGRect.make(x: (left_frame.width * 0.1), y: 15, width: (left_frame.width * 0.8), height: button_cell_height )
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
    @buttons << made_3fg_button if App::Persistence['3pts'] == true

    missed_3fg_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    missed_3fg_button.frame = made_3fg_button.frame.below(20)
    missed_3fg_button.font = "Avenir-Black".uifont(18.0)
    missed_3fg_button.setTitle("Missed 3FG", forState: UIControlStateNormal)
    missed_3fg_button.tag = 8
    missed_3fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_3fg_button if App::Persistence['3pts'] == true
    
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
    
    turnover_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    turnover_button.frame = block_button.frame.below(20)
    turnover_button.font = "Avenir-Black".uifont(18.0)
    turnover_button.setTitle("Turnover", forState: UIControlStateNormal)
    turnover_button.tag = 9
    turnover_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << turnover_button
    
    # Adds the button to the scroll 
    @buttons.each {|button| 
       left_scroll << button }
  end
  
  # For the player picking Table
  def tableView(tableView, numberOfRowsInSection: section)
    return @players_teams[section].count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell
    end    
      cell.text = @players_teams[indexPath.section][indexPath.row].player_name
      cell.textColor = :white.uicolor
      cell.font = Device.ipad? ? "Avenir-Black".uifont(25) : "Avenir-Black".uifont(16)
      cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
      @data_tag[:player] = @players_teams[indexPath.section][indexPath.row]
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

  
  # Resets the menu, updates the labels 
  def process_data(sender)
    action_tag = sender.tag 
    accessed_player = @data_tag[:player]
    player_performance = current_game.performances.where(:player_dat).eq(accessed_player.id).first
    if action_tag == 1
      player_performance.made_fg
    elsif action_tag == 3
      player_performance.rebounds += 1
    elsif action_tag == 4
      player_performance.assists += 1 
    elsif action_tag == 5
      player_performance.made_3fg
    elsif action_tag == 2
      player_performance.total_field_goals += 1
    elsif action_tag == 6
      player_performance.steals += 1
    elsif action_tag == 7
      player_performance.blocks += 1
    elsif action_tag == 8
      player_performance.total_field_goals += 1
    elsif action_tag == 9
      player_performance.turnovers += 1
    end
    @team1_label.text = "#{current_game.tally_points(1)}"
    @team2_label.text = "#{current_game.tally_points(2)}"
    reset_menu
  end

  
  # Clears up the menu to prepare for the next number 
  def reset_menu
    @data_tag = {}
    @buttons.each {|button| button.enabled = false }
  end
  
  
end
