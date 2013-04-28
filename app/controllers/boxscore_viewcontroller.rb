class BoxscoreViewController < UIViewController
  
  def viewDidLoad
    super
    self.title = "Box Score"
    view.backgroundColor = :black.uicolor
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.titled("Load") { load_old_box }
    
    label_frame = CGRect.make(x: 0, y: 10, width: view.bounds.width, height: view.bounds.height)
    

    @table = UITableView.alloc.initWithFrame label_frame
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
  
  def load_old_box
    old_box = OldboxscoreViewController.new
    present_modal(UINavigationController.alloc.initWithRootViewController(old_box))
  end
  
end
