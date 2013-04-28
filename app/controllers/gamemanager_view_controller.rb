class GameManagerViewController < UIViewController
  def viewDidLoad
    super
    self.title = "Game Manager"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.done {self.dismissViewControllerAnimated true, completion: nil}
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
