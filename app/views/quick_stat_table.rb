class QStatTableDelegate
  
  def tableView(tableView, numberOfRowsInSection: section)
    @players = Player.all
    return @players.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = PlayerCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
  
    cell.name_label.text = @players[indexPath.row].player_name
    cell.position_label.text = @players[indexPath.row].position
    cell.points_label.text = @players[indexPath.row].points.to_s
    cell.rebounds_label.text = @players[indexPath.row].rebounds.to_s
    cell.assists_label.text = @players[indexPath.row].assists.to_s
    cell
  end
  
end