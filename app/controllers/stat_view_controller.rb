class StatViewController < UIViewController
  # left side view controller 
  
  def viewDidLoad
    super
    view.backgroundColor = "noisy_net.png".uicolor
    
    label_frame = CGRect.make(x: 0, y: 10, width: self.sidePanelController.leftVisibleWidth, height: 30)
    
    label = UILabel.alloc.initWithFrame label_frame
    label.font = UIFont.boldSystemFontOfSize(20)
    label.backgroundColor = :clear.uicolor
    label.textAlignment = :center.uialignment 
    label.textColor = :white.uicolor 
    label.text = "Stat View"
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin
    view << label 
    @players = Player.all

    @table = UITableView.alloc.initWithFrame label.frame.below.height(view.bounds.height)
    # table.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin
    @table.backgroundColor = :clear.uicolor
    @table.separatorColor = 0x667c83.uicolor
    @table.rowHeight = 65
    @table.dataSource = self 
    @table.addPullToRefreshWithActionHandler(
    Proc.new do 
      loadData
    end
    )
    view << @table 
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
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

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def loadData
    Dispatch::Queue.main.after(2){
      @table.reloadData
      @table.pullToRefreshView.stopAnimating
    }
  end
  
end
