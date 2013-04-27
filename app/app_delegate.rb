class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    # Handles the different behaviors of the sliding panels 
    viewController = JASidePanelController.alloc.init
    viewController.shouldDelegateAutorotateToVisiblePanel = false
    viewController.leftPanel = StatViewController.alloc.init
    viewController.centerPanel = UINavigationController.alloc.initWithRootViewController(AddGameViewController.alloc.init)
    @window.rootViewController = viewController
    @window.makeKeyAndVisible
    
    UINavigationBar.appearance.tintColor = 0x070d14.uicolor
    
    true
  end
  
  def shouldAutorotate
    return NO 
  end
  
end
