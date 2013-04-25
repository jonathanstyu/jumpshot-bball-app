class AddPlayerViewController < UIViewController
  def viewDidLoad
    super
    self.title = "Add Player"
    view.backgroundColor = "subtle_dots.png".uicolor
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.done {self.dismissViewControllerAnimated true, completion: nil}
    
    team1_pick = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    team1_pick.frame = CGRect.make(x: 10, y: 35, width: (view.bounds.width/2 - 20), height: 30)
    team1_pick.setTitle("Team 1", forState: UIControlStateNormal)
    team1_pick.tag = 1
    team1_pick.addTarget(self, action: "team_picked:", forControlEvents: UIControlEventTouchUpInside)
    view << team1_pick
    
    team2_pick = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    team2_pick.frame = team1_pick.frame.beside.right(10)
    team2_pick.setTitle("Team 2", forState: UIControlStateNormal)
    team2_pick.tag = 2
    team2_pick.addTarget(self, action: "team_picked:", forControlEvents: UIControlEventTouchUpInside)
    view << team2_pick
    
    @name_text_field = UITextField.new
    @name_text_field.frame = team1_pick.frame.below(15).width(view.bounds.width - 25).height(35)
    @name_text_field.placeholder = "Name of Player"
    @name_text_field.borderStyle = UITextBorderStyleRoundedRect
    view << @name_text_field
    
    @add_player = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add_player.frame = @name_text_field.frame.below(15).width(view.bounds.width-25).height(35)
    @add_player.setTitle("Add Player", forState: UIControlStateNormal)
    @add_player.setTitle("Choose Team!", forState: UIControlStateDisabled)
    @add_player.when(UIControlEventTouchUpInside) do
      save_player
    end
    view << @add_player
    
    reset_page
    
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def team_picked(sender)
    @player_data[:team_info] = sender.tag 
    @add_player.enabled = true
  end
  
  def save_player
    if @name_text_field.text == nil || @name_text_field.text == ""
      alert = UIAlertView.alloc.initWithTitle("Alert", message: "Please Add the Player's Name", delegate: self, cancelButtonTitle: "Okay", otherButtonTitles: nil)

      alert.show
      # alert = BW::UIAlertView.plain_text_input(options).on_click do |alert|
      #   @name_text_field[:player_name] = alert.plain_text_field.text 
      # end
      # alert.show 
    end
    @player_data[:player_name] = @name_text_field.text
    puts @player_data
  end
  
  def reset_page
    @player_data = {}
    @add_player.enabled = false
  end
  
end
