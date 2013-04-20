class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    viewController = JASidePanelController.alloc.init
    viewController.shouldDelegateAutorotateToVisiblePanel = false
    viewController.leftPanel = SettingsViewController.alloc.init
    viewController.centerPanel = UINavigationController.alloc.initWithRootViewController(AddGameViewController.alloc.init)
    viewController.rightPanel = StatViewController.alloc.init
    @window.rootViewController = viewController
    @window.makeKeyAndVisible
    
    true
  end
end
