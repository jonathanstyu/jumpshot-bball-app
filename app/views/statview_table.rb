class PlayerTableDelegate
  include SugarCube::Modal 
  
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
    cell.detailTextLabel.text = "Team #{selected_player.team}"
    # cell.AccessoryType = UITableViewCellAccessoryDetailDisclosureButton
    cell
  end
  
  # def tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
  #   player_panel = PlayerEditViewController.new
  #   present_modal(player_panel)
  # end
  
  
  
end