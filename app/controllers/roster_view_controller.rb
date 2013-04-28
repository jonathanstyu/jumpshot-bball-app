class RosterViewController < UIViewController
  include SugarCube::Modal 
  
  def viewDidLoad
    super
    self.title = "Roster"
    view.backgroundColor = :black.uicolor  
    layout_views  
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end
  
  def viewDidAppear(animated)
    @player_viewer.reloadData 
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def shouldAutorotate
    NO
  end
  
  def layout_views
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.titled("Add") { open_add_player }
    @player_viewer = UITableView.new
    @player_viewer.frame = CGRect.make(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    @player_viewer.delegate = @player_viewer.dataSource = self
    view << @player_viewer
  end
  
  # helper methods for persisting
  # def plist
  #   document('bball_players.plist')
  # end
  # 
  # def persist
  #   @players.writeToFile(plist, atomically: true)
  # end
  # 
  # def load_players
  #   if exists(plist)
  #     @players = NSArray.alloc.initWithContentsOfFile(plist)
  #   else
  #     @players = []
  #   end
  # end
  
  # Info for the table 
  def tableView(tableView, numberOfRowsInSection: section)
    @players = Player.all 
    return @players.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell
    end
    selected_player = @players[indexPath.row]
    cell.text = selected_player.player_name  
    cell.detailTextLabel.text = "Guard"
    cell.AccessoryType = UITableViewCellAccessoryDetailDisclosureButton
    cell
  end
  
  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
    player_panel = PlayerEditViewController.new
    self.navigationController.pushViewController(player_panel, animated: true)
  end

  def open_add_player
    options = { :title => "Authorization" }
    alert = BW::UIAlertView.login_and_password_input(options).on_click do |alert|
      alert.login_text_field.text    #=> "La Forge"
      alert.password_text_field.text #=> "Theta2997"
    end

    alert.show
  end
  
end
