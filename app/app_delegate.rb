class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")

    game_view = UINavigationController.alloc.initWithRootViewController(NewgameViewController.alloc.init)
    
    box_view = UINavigationController.alloc.initWithRootViewController(BoxindexViewController.alloc.init)
    
    roster_view = UINavigationController.alloc.initWithRootViewController(RosterViewController.alloc.init)
    
    settings_view = UINavigationController.alloc.initWithRootViewController(SettingsViewController.alloc.init)
    
    UINavigationBar.appearance.tintColor = 0x2c3e50.uicolor
    tab_controller = AKTabBarController.alloc.initWithTabBarHeight(45)
    tab_controller.viewControllers = [roster_view, game_view, box_view, settings_view]
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible
    
    set_up_settings
    
    true
  end

  # Helper functions that help record games 
  
  def set_up_settings
    App::Persistence['3pts'] = true
    App::Persistence['12pts'] = true
    App::Persistence['teamnumb'] = false
  end
  
  def applicationWillDidBecomeActive(application)
  end
  
end

