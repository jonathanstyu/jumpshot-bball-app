class BoxscoreViewController < UITableViewController
  include SugarCube::Modal
  attr_accessor :game
  
  def viewDidLoad
    super
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.titled("Share") {share}
    self.title = "Box Score"
    tableView.backgroundColor = 0xecf0f1.uicolor
    tableView.separatorColor = 0x7f8c8d.uicolor
    tableView.rowHeight = 135
    tableView.dataSource = tableView.delegate = self
    tableView.addPullToRefreshWithActionHandler(
    Proc.new do 
      loadData
    end
    )

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
    @performances = Performance.where(:game_dat).eq(game.id).all
    return (@performances.count / 2)
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
  
    players = [game.team_1, game.team_2]
    @selected_player = Player.where(:id).eq(players[indexPath.section][indexPath.row].to_i).first
    performance = Performance.where(:game_dat).eq(game.id).and(:player_dat).eq(@selected_player.id).first
    
    cell.date_label.text = @selected_player.player_name
    cell.date_label.lineBreakMode = NSLineBreakByWordWrapping
    cell.date_label.numberOfLines = 0
    
    cell.points_label.text = performance.points.to_s
    cell.fg_label.text = performance.fg
    cell.ft_label.text = performance.ft
    cell.fg3_label.text = performance.threefg
    cell.rebounds_label.text = performance.rebounds.to_s
    cell.assists_label.text = performance.assists.to_s
    cell.steals_label.text = performance.steals.to_s
    cell.blocks_label.text = performance.blocks.to_s
    cell.to_label.text = performance.turnovers.to_s
    cell.f_label.text = performance.fouls.to_s    

    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    # player_panel = ViewplayerViewController.alloc.initWithPlayer(@selected_player)
    # self.navigationController.pushViewController(player_panel, animated: true)
  end
  
  def loadData
    Dispatch::Queue.main.after(2){
      view.reloadData
      tableView.pullToRefreshView.stopAnimating
    }
  end
  
  def share
    mail = MFMailComposeViewController.new
    mail.mailComposeDelegate = self 
    mail.setSubject("Game Statistics")
    mail.setMessageBody(game.export_data, isHTML: false)
    present_modal(mail)
  end
  
  def mailComposeController(mailView, didFinishWithResult: result, error: error)
    self.dismissModalViewControllerAnimated(true)
  end
  
end
