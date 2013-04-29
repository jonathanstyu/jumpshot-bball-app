class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    game_view = UINavigationController.alloc.initWithRootViewController(NewgameViewController.alloc.init)
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
        
    addGame
    
    true
  end
  
  def shouldAutorotate
    return NO 
  end

  # Helper functions that help record games 
  def addGame
    Player.create(:player_name => "Jon", :team => 1)
    Player.create(:player_name => "Paul", :team => 1)
    Player.create(:player_name => "Rick", :team => 2)
    Player.create(:player_name => "Carl", :team => 2)
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
