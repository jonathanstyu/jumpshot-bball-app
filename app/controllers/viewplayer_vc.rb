class ViewplayerViewController < UIViewController
  attr_accessor :player
  
  def viewDidLoad
    super
    self.title = "Profile"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.titled("Share") {share}
    layout_views
  end
  
  def initWithPlayer(player)
    initWithNibName(nil, bundle:nil)
    self.player = player
    self
  end
  
  def loadView
    if Device.ipad?
      views = NSBundle.mainBundle.loadNibNamed 'ipad-playerprofile', owner:self, options:nil
    else
      views = NSBundle.mainBundle.loadNibNamed 'iphone-playerprofile', owner:self, options:nil
    end
    self.view = views[0]
  end

  def layout_views
    
    @name_label = view.viewWithTag 7
    @name_label.text = player.player_name.downcase
    
    @pts_avg_label = view.viewWithTag 4
    @pts_avg_label.text = "#{player.average(:points)}"
    
    @reb_avg_label = view.viewWithTag 5
    @reb_avg_label.text = "#{player.average(:rebounds)}"
    
    @ast_avg_label = view.viewWithTag 6
    @ast_avg_label.text = "#{player.average(:assists)}"
    
    if Device.ipad?
      @st_avg_label = view.viewWithTag 8
      @st_avg_label.text = "#{player.average(:steals)}"

      @bl_avg_label = view.viewWithTag 9
      @bl_avg_label.text = "#{player.average(:blocks)}"

      @to_avg_label = view.viewWithTag 10
      @to_avg_label.text = "#{player.average(:turnovers)}"
    end
    
    @performance_table = view.viewWithTag 1
    @performance_table.delegate = @performance_table.dataSource = self
    if Device.ipad?
      @performance_table.rowHeight = 135
    else
      @performance_table.rowHeight = 120
    end
    @performance_table.addPullToRefreshWithActionHandler(
    Proc.new do 
      loadData
    end
    )
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @performances = player.return_statlines
    return @performances.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = ProfileCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
    performance = @performances[indexPath.row]

    cell.date_label.text = performance.game_name
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

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
  
  def loadData
    Dispatch::Queue.main.after(2) {
      @performance_table.reloadData
      @performance_table.pullToRefreshView.stopAnimating
      @pts_avg_label.text = "#{player.average(:points)}"
      @reb_avg_label.text = "#{player.average(:rebounds)}"
      @ast_avg_label.text = "#{player.average(:assists)}"
      if Device.ipad?
        @st_avg_label.text = "#{player.average(:steals)}"
        @bl_avg_label.text = "#{player.average(:blocks)}"
        @to_avg_label.text = "#{player.average(:turnovers)}"
      end
    }
  end

  def share
    mail = MFMailComposeViewController.new
    mail.mailComposeDelegate = self 
    mail.setSubject("Player Profile Statistics")
    mail.setMessageBody(player.export_data, isHTML: false)
    present_modal(mail)
  end
  
  def mailComposeController(mailView, didFinishWithResult: result, error: error)
    self.dismissModalViewControllerAnimated(true)
  end
  
end
