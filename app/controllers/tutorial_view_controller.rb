class TutorialViewController < UIViewController
  include SugarCube::Modal
  
  def viewDidLoad
    super
    view.backgroundColor = 0xf4f4f4.uicolor
    
    dismiss_button = FlatPillButton.new
    dismiss_button.frame = CGRect.make(x: view.bounds.width * 0.20, y: 5, width: view.bounds.width * 0.60, height: 25)
    dismiss_button.setTitle("Dismiss", forState: UIControlStateNormal)
    dismiss_button.on(:touch) {dismiss_modal}
    view << dismiss_button
    
    screen = UIPageControl.new
    screen.backgroundColor = :white.uicolor
    screen.frame = CGRect.make(x: 0, y:30, width: view.bounds.width, height: view.bounds.height - 30)
    screen.contentSize = CGSizeMake(view.bounds.width * 4, view.bounds.height - 30)
    screen.pagingEnabled = true
    view << screen 
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
