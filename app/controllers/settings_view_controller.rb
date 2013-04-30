class SettingsViewController < UIViewController
  # The right side panel view
  
  def viewDidLoad
    super
    self.title = "Settings"
    view.backgroundColor = "noisy_net.png".uicolor        
    
  end

  def viewDidUnload
    super
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
