class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    # Handles the different behaviors of the sliding panels 
    # viewController = JASidePanelController.alloc.init
    # viewController.shouldDelegateAutorotateToVisiblePanel = false
    game_view = UINavigationController.alloc.initWithRootViewController(GameViewController.alloc.init)
    game_view.title = "Game"
    box_view = UINavigationController.alloc.initWithRootViewController(BoxscoreViewController.alloc.init)
    box_view.title = "Box Score"
    roster_view = UINavigationController.alloc.initWithRootViewController(RosterViewController.alloc.init)
    roster_view.title = "Roster"
    settings_view = UINavigationController.alloc.initWithRootViewController(SettingsViewController.alloc.init)
    settings_view.title = "Settings"

    UINavigationBar.appearance.tintColor = :black.uicolor
    tab_controller = UITabBarController.alloc.init
    tab_controller.viewControllers = [game_view, box_view, roster_view, settings_view]
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible
        
    true
  end
  
  def shouldAutorotate
    return NO 
  end
  
end
