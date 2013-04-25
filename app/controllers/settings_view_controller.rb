class SettingsViewController < UIViewController
  # The right side panel view
  
  def viewDidLoad
    super
    view.backgroundColor = "noisy_net.png".uicolor        
    
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
