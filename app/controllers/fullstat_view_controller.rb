class FullStatViewController < UIViewController
  def viewDidLoad
    super
    self.title = "Full Box Score"
    view.backgroundColor = "noisy_net.png".uicolor
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
