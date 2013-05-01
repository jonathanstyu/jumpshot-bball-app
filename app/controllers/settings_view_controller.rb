class SettingsViewController < UIViewController
  include MotionTable::GroupedTable
  
  def viewDidLoad
    super
    self.title = "Settings"
    @grouped_table_view_data ||= [{
      title: "Game Recording Settings",
      cells: [
        {title: "3 pointers allowed", accessoryAction: :toggle_3pts, accessory: :switch, accessoryDefault: true},
        {title: "1/2s or 2/3s", accessoryAction: :toggle_12, accessory: :switch, accessoryDefault: true}
      ]
    }, {
      title: "App Made With ...", 
      cells: [
        {title: "Rubymotion"}, 
        {title: "Bubblewrap"},
        {title: "Motion-Model"},
        {title: "Sugarcube"}
      ]
    }]
    self.view = self.createTableViewFromData(@grouped_table_view_data)
  end

  def viewDidUnload
    super
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def toggle_3pts
  end
  
  def toggle_12
  end
  
end
