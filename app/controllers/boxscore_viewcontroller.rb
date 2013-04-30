class BoxscoreViewController < UIViewController
  attr_accessor :game
  
  def viewDidLoad
    super
    self.title = "Box Score"
    view.backgroundColor = :white.uicolor
    
    label_frame = CGRect.make(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)

    @table = UITableView.alloc.initWithFrame label_frame
    @table.backgroundColor = :clear.uicolor
    @table.separatorColor = :white.uicolor
    @table.rowHeight = 135
    @table.delegate = @table.dataSource = self
    view << @table 
  end
  
  def initWithGame(game)
    self.game = game
    self
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @performances = game.return_team_performances
    return @performances[section].count
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
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = ProfileCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
    performance = @performances[indexPath.section][indexPath.row]
    players = [game.team_1, game.team_2]
    cell.date_label.text = players[indexPath.section][indexPath.row].player_name
    cell.points_label.text = performance.points.to_s
    cell.fg_label.text = "#{performance.made_field_goals.to_s}/#{performance.total_field_goals.to_s}"
    cell.rebounds_label.text = performance.rebounds.to_s
    cell.assists_label.text = performance.assists.to_s
    cell.steals_label.text = performance.steals.to_s
    cell.blocks_label.text = performance.blocks.to_s

    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    player_panel = ViewplayerViewController.alloc.initWithPlayer(@players[indexPath.row])
    self.navigationController.pushViewController(player_panel, animated: true)
  end
  
end
