class NewgameViewController < UIViewController
  include SugarCube::Modal 
  # attr_accessor :game
  
  def viewDidLoad
    super
    self.title = "New Game"
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
    # self.navigationItem.leftBarButtonItem = UIBarButtonItem.cancel {self.dismissViewControllerAnimated true, completion: nil}
    
    save_players = FlatPillButton.new
    save_players.frame = CGRect.make(x: 10, y: 20, width: (view.bounds.width/2 - 20), height: 30)
    save_players.setTitle("Start Game", forState: UIControlStateNormal)
    save_players.addTarget(self, action: "save_players", forControlEvents: UIControlEventTouchUpInside)
    view << save_players
    
    open_edit = FlatPillButton.new
    open_edit.frame = save_players.frame.beside.right(10)
    open_edit.setTitle("Clear Teams", forState: UIControlStateNormal)
    open_edit.setTitle("Disabled", forState: UIControlStateDisabled)
    open_edit.addTarget(self, action: "clear_teams", forControlEvents: UIControlEventTouchUpInside)
    view << open_edit
    
    @player_viewer = UITableView.new
    @player_viewer.frame = CGRect.make(x: 0, y: 70, width: view.bounds.width, height: view.bounds.height- 70)
    @player_viewer.delegate = @player_viewer.dataSource = self
    @player_viewer.backgroundColor = :clear.uicolor
    @player_viewer.rowHeight = 75
    view << @player_viewer
  
  end
  
  def viewDidAppear(animated)
    @player_viewer.reloadSections(NSIndexSet.indexSetWithIndex(0), withRowAnimation:UITableViewRowAnimationAutomatic)
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
    
    cell.text = @players[indexPath.row].player_name
    cell.textLabel.font = :bold.uifont(19)
    cell.detailTextLabel.font = :bold.uifont(14)
    
    cell.detailTextLabel.text = "No Team"
    cell.mode = MCSwipeTableViewCellModeSwitch
    cell
  end
  
  def swipeTableViewCell(cell, didTriggerState: state, withMode: mode)
    cellIndex = @player_viewer.indexPathForCell(cell).row
    if state == 1
      cell.detailTextLabel.text = "Team 1"
      @team_assignments["#{@players[cellIndex].id}"] = "team1"
    elsif state == 2
      cell.detailTextLabel.text = "Team 2"
      @team_assignments["#{@players[cellIndex].id}"] = "team2"
    else
      cell.detailTextLabel.text = "No Team"
      @team_assignments["#{@players[cellIndex].id}"] = "none"
    end
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
      
  def save_players  
    player_values = @team_assignments.values
    if player_values.count {|x| x == 'team2'} == 0 || player_values.count {|x| x == 'team1'} == 0
      bad_input = UIAlertView.alloc.initWithTitle("Alert", message: "A team has no players!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      bad_input.show
    elsif player_values.count {|x| x == 'team1'} != player_values.count {|x| x == 'team2'} && App::Persistence['teamnumb'] == false
      # If setting says that uneven teams are allowed then this allows 
      unequal_teams = UIAlertView.alloc.initWithTitle("Alert", message: "Teams are unequal!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      unequal_teams.show
    else
      team_1 = []
      team_2 = []
      @team_assignments.each {|k, v| 
        if v == "team1"
          team_1 << k
        elsif v == 'team2'
          team_2 << k
        end
      }
      set_up = Game.create(:team_1 => team_1, :team_2 => team_2)
      game_play = GameViewController.alloc.initWithGame(set_up)
      self.navigationController.pushViewController(game_play, animated: true)
    end
    
  end
  
  def clear_teams
    @player_viewer.reloadSections(NSIndexSet.indexSetWithIndex(0), withRowAnimation:UITableViewRowAnimationAutomatic) 
    @team_assignments.clear 
  end
  
end
