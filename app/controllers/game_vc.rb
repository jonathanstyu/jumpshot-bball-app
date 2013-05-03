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
    current_game.create_performances
    self
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end
  
  def viewDidAppear(animated)
    @player_table.reloadData
  end
    
  def loadView
    if Device.ipad?
      views = NSBundle.mainBundle.loadNibNamed 'ipad-gamerec', owner:self, options:nil
    else
      views = NSBundle.mainBundle.loadNibNamed 'iphone-gamerec', owner:self, options:nil
    end
    self.view = views[0]
  end
  
  def layout_views
    
    @team1_label = view.viewWithTag 4
    @team1_label.text = "0"
    
    @team2_label = view.viewWithTag 5
    @team2_label.text = "0"
    
    # Panel for the action recording buttons 
    left_scroll = view.viewWithTag 6  
    left_scroll.backgroundColor = "subtle_dots.png".uicolor
    
    @player_table = view.viewWithTag 1
    @player_table.separatorColor = :white.uicolor
    @player_table.rowHeight = 100 if Device.ipad?
    @player_table.dataSource = @player_table.delegate = self 
    
    # Adds the function buttons to track points and scored
    @buttons = []
    
    made_fg_button = view.viewWithTag 7
    made_fg_button.tag = 1
    made_fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    
    @buttons << made_fg_button 
    
    missed_fg_button = view.viewWithTag 8
    missed_fg_button.tag = 2
    missed_fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_fg_button 
    
    made_3fg_button = view.viewWithTag 9
    made_3fg_button.tag = 5
    made_3fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_3fg_button if App::Persistence['3pts'] == true

    missed_3fg_button = view.viewWithTag 10
    missed_3fg_button.tag = 8
    missed_3fg_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_3fg_button if App::Persistence['3pts'] == true
    
    made_ft_button = view.viewWithTag 11
    made_ft_button.tag = 10
    made_ft_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << made_ft_button 

    missed_ft_button = view.viewWithTag 12
    missed_ft_button.tag = 11
    missed_ft_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << missed_ft_button 
    
    rebound_button = view.viewWithTag 13
    rebound_button.tag = 3
    rebound_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << rebound_button
    
    assist_button = view.viewWithTag 14
    assist_button.tag = 4
    assist_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << assist_button
    
    steal_button = view.viewWithTag 16
    steal_button.tag = 6
    steal_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << steal_button
    
    block_button = view.viewWithTag 15
    block_button.tag = 7
    block_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << block_button
    
    turnover_button = view.viewWithTag 17
    turnover_button.tag = 9
    turnover_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << turnover_button
    
    foul_button = view.viewWithTag 18
    foul_button.tag = 12
    foul_button.addTarget(self, action: "process_data:", forControlEvents: UIControlEventTouchUpInside)
    @buttons << foul_button
    
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
    elsif action_tag == 10
      player_performance.total_ft += 1
    elsif action_tag == 11
      player_performance.made_ft
    elsif action_tag == 12
      player_performance.fouls += 1
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
