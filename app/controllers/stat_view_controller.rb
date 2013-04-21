class StatViewController < UIViewController
  # Right side view controller 
  
  def viewDidLoad
    super
    view.backgroundColor = "noisy_net.png".uicolor
    
    label_frame = CGRect.make(x: view.bounds.width - self.sidePanelController.leftVisibleWidth, y: 10, width: self.sidePanelController.leftVisibleWidth, height: 30)
    
    label = UILabel.alloc.initWithFrame label_frame
    label.font = UIFont.boldSystemFontOfSize(20)
    label.backgroundColor = :clear.uicolor
    label.textAlignment = :center.uialignment 
    label.textColor = :white.uicolor 
    label.text = "Hello There"
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin
    view << label 
    
    table = UITableView.alloc.initWithFrame label_frame.below(10).taller(100)
    view << table
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    return 1 
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    
    cell.backgroundColor = :clear.uicolor
    
    cell
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
