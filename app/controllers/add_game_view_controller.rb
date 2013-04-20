class AddGameViewController < UIViewController
  # The center view of the app
  
  def viewDidLoad
    super
    self.title = "Add Game"
    view.backgroundColor = UIColor.whiteColor
    
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
