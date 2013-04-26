class StatViewController < UIViewController
  # left side view controller 
  
  def viewDidLoad
    super
    view.backgroundColor = "noisy_net.png".uicolor
    
    label_frame = CGRect.make(x: 0, y: 10, width: self.sidePanelController.leftVisibleWidth, height: 30)
    
    label = UILabel.alloc.initWithFrame label_frame
    label.font = UIFont.boldSystemFontOfSize(18)
    label.backgroundColor = :clear.uicolor
    label.textAlignment = :center.uialignment 
    label.textColor = :white.uicolor 
    label.text = "Quick Stat View"
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin
    view << label 

    @table = UITableView.alloc.initWithFrame label.frame.below.height(view.bounds.height - 60)
    # table.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin
    @table.backgroundColor = :clear.uicolor
    @table.separatorColor = 0x667c83.uicolor
    @table.rowHeight = 65
    @table_delegate = QStatTableDelegate.new
    @table.delegate = @table.dataSource =  @table_delegate
    @table.addPullToRefreshWithActionHandler(
    Proc.new do 
      loadData
    end
    )
    view << @table 
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
