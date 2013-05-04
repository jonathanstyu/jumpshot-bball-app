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
    open_edit.setTitle("Assign Teams", forState: UIControlStateNormal)
    open_edit.setTitle("Disabled", forState: UIControlStateDisabled)
    open_edit.addTarget(self, action: "later", forControlEvents: UIControlEventTouchUpInside)
    open_edit.enabled = false
    view << open_edit
    
    @player_viewer = UITableView.new
    @player_viewer.frame = CGRect.make(x: 0, y: 70, width: view.bounds.width, height: view.bounds.height)
    @player_viewer.delegate = @player_viewer.dataSource = self
    @player_viewer.backgroundColor = :clear.uicolor
    view << @player_viewer
  
  end
  
  def viewDidAppear(animated)
    @player_viewer.reloadData
    @player_viewer.setEditing(true, animated: true)
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    openroster = Array.new(Player.all)
    players_team1 = []
    players_team2 = []
    @players = [openroster, players_team1, players_team2]
    return @players[section].count
  end
  
  def tableView(tableView, canEditRowAtIndexPath: indexPath)
    return true
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell
    end
    
    cell.text = @players[indexPath.section][indexPath.row].player_name
    
    cell
  end
  
  def numberOfSectionsInTableView(tableView)
    3
  end

  def tableView(tableView, titleForHeaderInSection: section)
    if section == 0 
      return "Available Roster"
    elsif section == 1
      return "Team 1"
    else
      return "Team 2"
    end
  end
  
  def tableView(tableView, canMoveRowAtIndexPath: indexPath)
    return true
  end
  
  def tableView(tableView, moveRowAtIndexPath: fromIndexPath, toIndexPath: toIndexPath)
    player_to_move = @players[fromIndexPath.section][fromIndexPath.row]
    @players[toIndexPath.section] << player_to_move
    @players[fromIndexPath.section].delete(player_to_move)
  end
  
  def tableView(tableView, editingStyleForRowAtIndexPath: indexPath)
    return UITableViewCellEditingStyleNone
  end
  
  def tableView(tableView, shouldIndentWhileEditingRowAtIndexPath: indexPath)
    return false
  end
      
  def save_players  
    if @players[1].count == 0 || @players[2].count == 0
      bad_input = UIAlertView.alloc.initWithTitle("Alert", message: "A team has no players!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      bad_input.show
    elsif @players[1].count != @players[2].count && App::Persistence['teamnumb'] == false
      # If setting says that uneven teams are allowed then this allows 
      unequal_teams = UIAlertView.alloc.initWithTitle("Alert", message: "Teams are unequal!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      unequal_teams.show
    else
      set_up = Game.create(:team_1 => @players[1], :team_2 => @players[2])
      game_play = GameViewController.alloc.initWithGame(set_up)
      self.navigationController.pushViewController(game_play, animated: true)
    end
  end
  
end
