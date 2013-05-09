class RosterViewController < UIViewController
  include SugarCube::Modal 
  
  def viewDidLoad
    super
    self.title = "Roster"
    view.backgroundColor = 0xf4f4f4.uicolor  
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
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, action: :open_add_player)
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    
    @player_viewer = UITableView.new
    @player_viewer.frame = CGRect.make(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    @player_viewer.delegate = @player_viewer.dataSource = self
    @player_viewer.backgroundColor = 0xecf0f1.uicolor
    @player_viewer.separatorColor = 0x7f8c8d.uicolor
    @player_viewer.rowHeight = 75
    view << @player_viewer
  end
  
  # Info for the table 
  def tableView(tableView, numberOfRowsInSection: section)
    @players = Player.all 
    return @players.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = IndexCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
    selected_player = @players[indexPath.row]
    cell.name_label.text = selected_player.name  
    cell.info_label.text = "avg:"
    cell.ptsaverage.text = "#{selected_player.average(:points)} pts"
    cell.rebaverage.text = "#{selected_player.average(:rebounds)} reb"
    cell.astaverage.text = "#{selected_player.average(:assists)} ast"
    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    player_panel = ViewplayerViewController.alloc.initWithPlayer(@players[indexPath.row])
    self.navigationController.pushViewController(player_panel, animated: true)
  end
  
  def tableView(tableView, commitEditingStyle: editing_style, forRowAtIndexPath: indexPath)
    if editing_style == UITableViewCellEditingStyleDelete
      @players.delete_at(indexPath.row)
      @player_viewer.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationAutomatic)
    end
  end

  def open_add_player
      UIActionSheet.alert('Add from where?', buttons: ['Cancel', nil, 'Address Book', 'Manually']) {
        |pressed| 
        self.manual_player_add if pressed == 'Manually'
        self.address_player_add if pressed == 'Address Book'
      }
    
  end
  
  def alertView(alertView, clickedButtonAtIndex: buttonIndex)
    if buttonIndex == 1
      if name_check("#{alertView.textFieldAtIndex(0).text}")
        new_player = Player.create_new(alertView.textFieldAtIndex(0).text)
      else
        name_used = UIAlertView.alloc.initWithTitle("Alert", message: "Player with same name already exists!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
        name_used.show
      end
      @player_viewer.reloadData
    end
  end
  
  def setEditing(is_editing, animated: is_animated)
    @player_viewer.setEditing(is_editing, animated: is_animated)
    super
  end
  
  def manual_player_add
    alert = UIAlertView.alloc.initWithTitle("Add Player", message: "What is the player's name?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok", nil)
    alert.alertViewStyle = UIAlertViewStylePlainTextInput
    alert.show
  end
  
  # Implements the ABPeoplePicker controller that pops up modally to add a person 
  def address_player_add
    picker = ABPeoplePickerNavigationController.alloc.init
    picker.peoplePickerDelegate = self 
    picker.displayedProperties = [KABPersonFirstNameProperty, KABPersonLastNameProperty, KABPersonEmailProperty]
    self.presentModalViewController(picker, animated: true)
  end
  
  def peoplePickerNavigationControllerDidCancel(peoplePicker)
    self.dismissModalViewControllerAnimated(true)
  end
  
  def peoplePickerNavigationController(peoplePicker, shouldContinueAfterSelectingPerson: person, property: property, identifier: identifier)
    firstname = ABRecordCopyValue(person, KABPersonFirstNameProperty)
    lastname = ABRecordCopyValue(person, KABPersonLastNameProperty)
    email = ABRecordCopyValue(person, KABPersonEmailProperty)
    if name_check("#{firstname} #{lastname}")
      new_player = Player.create_new("#{firstname} #{lastname}")
    else
      name_used = UIAlertView.alloc.initWithTitle("Alert", message: "Player with same name already exists!", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)
      name_used.show
    end
    self.dismissModalViewControllerAnimated(true)
    return false
  end
  
  def name_check(name)
    if Player.find(:name => "#{name}").count > 0
      return false 
    else
      return true
    end
  end

  
end
