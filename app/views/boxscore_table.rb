class QStatTableDelegate
  
  def tableView(tableView, numberOfRowsInSection: section)
    @players_team1 = Player.where(:team).eq(1).all
    @players_team2 = Player.where(:team).eq(2).all
    if section == 0
      return @players_team1.count
    else
      return @players_team2.count
    end
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = PlayerCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
    
    if indexPath.section == 0      
      cell.name_label.text = @players_team1[indexPath.row].player_name
      cell.team_label.text = "Team #{@players_team1[indexPath.row].team}"
      cell.points_label.text = @players_team1[indexPath.row].points.to_s
      cell.rebounds_label.text = @players_team1[indexPath.row].rebounds.to_s
      cell.assists_label.text = @players_team1[indexPath.row].assists.to_s
    else
      cell.name_label.text = @players_team2[indexPath.row].player_name
      cell.team_label.text = "Team #{@players_team2[indexPath.row].team}"
      cell.points_label.text = @players_team2[indexPath.row].points.to_s
      cell.rebounds_label.text = @players_team2[indexPath.row].rebounds.to_s
      cell.assists_label.text = @players_team2[indexPath.row].assists.to_s
    end

    cell
  end
  
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
  
end