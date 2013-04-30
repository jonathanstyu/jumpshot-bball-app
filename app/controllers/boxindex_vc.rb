class BoxindexViewController < UITableViewController
  def viewDidLoad
    super
    self.title = "Box Scores"
    # self.navigationItem.leftBarButtonItem = UIBarButtonItem.done {self.dismissViewControllerAnimated true, completion: nil}
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @games = Game.all 
    return @games.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell
    end
    selected_game = @games[indexPath.row]
    cell.text = selected_game.date_played.strftime("%m - %d - %Y")
    cell.detailTextLabel.text = "Location"
    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    game_panel = BoxscoreViewController.alloc.initWithGame(@games[indexPath.row])
    self.navigationController.pushViewController(game_panel, animated: true)
  end
end
