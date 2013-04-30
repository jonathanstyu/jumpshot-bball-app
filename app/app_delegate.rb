class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    game_view = UINavigationController.alloc.initWithRootViewController(NewgameViewController.alloc.init)
    game_view.title = "Game"
    box_view = UINavigationController.alloc.initWithRootViewController(BoxindexViewController.alloc.init)
    box_view.title = "Box Scores"
    roster_view = UINavigationController.alloc.initWithRootViewController(RosterViewController.alloc.init)
    roster_view.title = "Roster"
    settings_view = UINavigationController.alloc.initWithRootViewController(SettingsViewController.alloc.init)
    settings_view.title = "Settings"

    UINavigationBar.appearance.tintColor = :black.uicolor
    tab_controller = UITabBarController.alloc.init
    tab_controller.viewControllers = [game_view, box_view, roster_view, settings_view]
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible
    
    set_up_local_data
    
    true
  end

  # Helper functions that help record games 
  def set_up_local_data
    Player.deserialize_from_file('players.dat')
    Game.deserialize_from_file('games.dat')
    Performance.deserialize_from_file('performance.dat')
  end
  
  def applicationWillResignActive(application)
    Game.serialize_to_file('games.dat')
    Performance.serialize_to_file('performance.dat')
    Player.serialize_to_file('players.dat')
  end
  
end

