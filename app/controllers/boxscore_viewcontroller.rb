class BoxscoreViewController < UITableViewController
  include SugarCube::Modal
  attr_accessor :game
  
  def viewDidLoad
    super
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.titled("Share") {share}
    self.title = "#{game.date_played}"
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
    @performances = Statline.find(:game_key => game.key)
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
  
    players = [game.team1, game.team2]
    statline = Statline.find(:game_key => game.key, :player_key => players[indexPath.section][indexPath.row]).first
    
    cell.date_label.text = statline.player_key
    cell.date_label.lineBreakMode = NSLineBreakByWordWrapping
    cell.date_label.numberOfLines = 0
    
    cell.points_label.text = statline.points.to_s
    cell.fg_label.text = "#{statline.fg_m}/#{statline.fg_a}"
    cell.ft_label.text = "#{statline.ft_m}/#{statline.ft_a}"
    cell.fg3_label.text = "#{statline.threefg_m}/#{statline.threefg_a}"
    cell.rebounds_label.text = statline.rebounds.to_s
    cell.assists_label.text = statline.assists.to_s
    cell.steals_label.text = statline.steals.to_s
    cell.blocks_label.text = statline.blocks.to_s
    cell.to_label.text = statline.turnovers.to_s
    cell.f_label.text = statline.fouls.to_s    

    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
