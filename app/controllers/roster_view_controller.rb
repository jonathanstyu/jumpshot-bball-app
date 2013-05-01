class RosterViewController < UIViewController
  include SugarCube::Modal 
  
  def viewDidLoad
    super
    self.title = "Roster"
    view.backgroundColor = :black.uicolor  
    layout_views  
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end
  
  def viewDidAppear(animated)
    @player_viewer.reloadData 
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def shouldAutorotate
    NO
  end
  
  def layout_views
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, action: :open_add_player)
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    
    @player_viewer = UITableView.new
    @player_viewer.frame = CGRect.make(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    @player_viewer.delegate = @player_viewer.dataSource = self
    view << @player_viewer
  end
  
  # Info for the table 
  def tableView(tableView, numberOfRowsInSection: section)
    @players = Player.all 
    return @players.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell
    end
    selected_player = @players[indexPath.row]
    cell.text = selected_player.player_name  
    cell.detailTextLabel.text = "Guard"
    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    player_panel = ViewplayerViewController.alloc.initWithPlayer(@players[indexPath.row])
    self.navigationController.pushViewController(player_panel, animated: true)
  end
  
  def tableView(tableView, commitEditingStyle: editing_style, forRowAtIndexPath: indexPath)
    if editing_style == UITableViewCellEditingStyleDelete
      @players.delete_at(indexPath.row)
      @player_viewer.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationAutomatic)
    end
  end

  def open_add_player
    alert = UIAlertView.alloc.initWithTitle("Add Player", message: "What is the player's name?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok", nil)
    alert.alertViewStyle = UIAlertViewStylePlainTextInput
    alert.show
  end
  
  def alertView(alertView, clickedButtonAtIndex: buttonIndex)
    if buttonIndex == 1
      new_player = Player.create(:player_name => alertView.textFieldAtIndex(0).text)
      @player_viewer.reloadData
    end
  end
  
  def setEditing(is_editing, animated: is_animated)
    @player_viewer.setEditing(is_editing, animated: is_animated)
    super
  end
  
end
