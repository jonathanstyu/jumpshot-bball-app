class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")

    game_view = UINavigationController.alloc.initWithRootViewController(NewgameViewController.alloc.init)
    game_view.title = "Game"
    game_view.tabBarItem.setFinishedSelectedImage("bball.png".uiimage, withFinishedUnselectedImage:"bball.png".uiimage)
    
    box_view = UINavigationController.alloc.initWithRootViewController(BoxindexViewController.alloc.init)
    box_view.title = "Box Scores"
    box_view.tabBarItem.setFinishedSelectedImage("box.png".uiimage, withFinishedUnselectedImage:"box.png".uiimage)
    
    roster_view = UINavigationController.alloc.initWithRootViewController(RosterViewController.alloc.init)
    roster_view.title = "Roster"
    roster_view.tabBarItem.setFinishedSelectedImage("roster.png".uiimage, withFinishedUnselectedImage:"roster.png".uiimage)
    
    settings_view = UINavigationController.alloc.initWithRootViewController(SettingsViewController.alloc.init)
    settings_view.title = "Settings"
    settings_view.tabBarItem.setFinishedSelectedImage("settings.png".uiimage, withFinishedUnselectedImage:"settings.png".uiimage)
    
    UINavigationBar.appearance.tintColor = 0x2c3e50.uicolor
    tab_controller = UITabBarController.alloc.init
    tab_controller.viewControllers = [game_view, box_view, roster_view, settings_view]
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

