class NewgameViewController < UITableViewController
  include SugarCube::Modal 
  # attr_accessor :game
  
  def viewDidLoad
    super
    self.title = "New"
    view.backgroundColor = :white.uicolor
    layout_views
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def layout_views
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.titled("Start") {save_players}
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.titled("Clear") {clear_teams}
    
    tableView.delegate = tableView.dataSource = self
    tableView.backgroundColor = 0xecf0f1.uicolor
    tableView.separatorColor = 0x7f8c8d.uicolor
    if Device.ipad?
      tableView.rowHeight = 75
    else
      tableView.rowHeight = 65
    end
  
  end
  
  def viewDidAppear(animated)
    tableView.reloadSections(NSIndexSet.indexSetWithIndex(0), withRowAnimation:UITableViewRowAnimationAutomatic)
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @team_assignments = {}
    @players = Array.new(Player.all)
    return @players.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = MCSwipeTableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)
      cell.delegate = self
      cell.setFirstStateIconName("team_1.png", firstColor: nil, secondStateIconName: "team_2.png", secondColor: nil, thirdIconName: "cross.png", thirdColor: nil, fourthIconName: nil, fourthColor: nil)
      cell
    end
    
    cell.text = @players[indexPath.row].name
    cell.textLabel.font = :bold.uifont(19)
    cell.detailTextLabel.font = :bold.uifont(14)
    
    cell.detailTextLabel.text = "No Team"
    cell.mode = MCSwipeTableViewCellModeSwitch
    cell
  end
  
  def swipeTableViewCell(cell, didTriggerState: state, withMode: mode)
    cellIndex = self.tableView.indexPathForCell(cell).row
    if state == 1
      cell.detailTextLabel.text = "Team 1"
      @team_assignments["#{@players[cellIndex].name}"] = "team1"
    elsif state == 2
      cell.detailTextLabel.text = "Team 2"
      @team_assignments["#{@players[cellIndex].name}"] = "team2"
    else
      cell.detailTextLabel.text = "No Team"
      @team_assignments["#{@players[cellIndex].name}"] = "none"
    end
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
      
  def save_players  
    player_values = @team_assignments.values
    if player_values.count {|x| x == 'team2'} == 0 || player_values.count {|x| x == 'team1'} == 0
      # If there is a set up where a team has no players, it is not fair, right?
      bad_input = UIAlertView.alloc.initWithTitle("Alert", message: "A team has no players!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      bad_input.show
    elsif player_values.count {|x| x == 'team1'} != player_values.count {|x| x == 'team2'} && App::Persistence['teamnumb'] == false
      # If setting says that uneven teams are allowed then this allows 
      unequal_teams = UIAlertView.alloc.initWithTitle("Alert", message: "Teams are unequal!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      unequal_teams.show
    else
      team_1 = []
      team_2 = []
      # Looks at each player and assigns them to their individual things 
      @team_assignments.each {|k, v| 
        if v == "team1"
          team_1 << k
        elsif v == 'team2'
          team_2 << k
        end
      }
      set_up = Game.create_new(team_1, team_2)
      game_play = GameViewController.alloc.initWithGame(set_up)
      self.navigationController.pushViewController(game_play, animated: true)
    end
    
  end
  
  def clear_teams
    self.tableView.reloadSections(NSIndexSet.indexSetWithIndex(0), withRowAnimation:UITableViewRowAnimationAutomatic) 
    @team_assignments.clear 
  end
  
  def tabImageName
    return "bball.png"
  end
  
  def tabTitle
    return "Start A Game"
  end
  
end
