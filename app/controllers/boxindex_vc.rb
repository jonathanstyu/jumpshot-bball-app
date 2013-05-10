class BoxindexViewController < UITableViewController
  def viewDidLoad
    super
    self.title = "Box Scores"
    # self.navigationItem.leftBarButtonItem = self.editButtonItem
    view.backgroundColor = 0xecf0f1.uicolor
    view.separatorColor = 0x7f8c8d.uicolor
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
  
  def viewDidAppear(animated)
    tableView.reloadData 
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell
    end
    selected_game = @games[indexPath.row]
    cell.text = selected_game.date_played
    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    game_panel = BoxscoreViewController.alloc.initWithGame(@games[indexPath.row])
    self.navigationController.pushViewController(game_panel, animated: true)
  end
  
  def tableView(tableView, commitEditingStyle: editing_style, forRowAtIndexPath: indexPath)
    if editing_style == UITableViewCellEditingStyleDelete
      a = @games[indexPath.row]
      a.delete
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationAutomatic)
    end
  end
  
  def setEditing(is_editing, animated: is_animated)
    tableView.setEditing(is_editing, animated: is_animated)
    super
  end
  
  # Handles the custom tab 
  def tabImageName
    return 'box.png'
  end
  
  def tabTitle
    return 'Box Scores'
  end
  
end
