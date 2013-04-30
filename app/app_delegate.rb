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
    
    addGame
    
    true
  end

  # Helper functions that help record games 
  def addGame
    jon = Player.create(:player_name => "Jon")
    paul = Player.create(:player_name => "Paul")
    rick = Player.create(:player_name => "Rick")
    matt = Player.create(:player_name => "Matt")
    game1 = Game.create(:date_played => Time.new, :team_1 => [jon, paul], :team_2 => [rick, matt])
    game2 = Game.create(:date_played => Time.new, :team_1 => [paul, matt], :team_2 => [rick, jon])
    game1.create_performances
    game2.create_performances
  end
  
end

class Kernel
  
  def document(filename)
    @docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    @docs.stringByAppendingPathComponent(filename)
  end
  
  def exists(filename)
    NSFileManager.defaultManager.fileExistsAtPath(filename)
  end
  
end
