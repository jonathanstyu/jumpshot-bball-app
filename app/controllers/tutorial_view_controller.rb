class TutorialViewController < UIViewController
  include SugarCube::Modal
  
  def viewDidLoad
    super
    view.backgroundColor = 0xecf0f1.uicolor
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.titled("Close") {dismiss_modal}
    
    self.view = UIWebView.new
    url = NSURL.URLWithString("https://googledrive.com/host/0BxpHKace-ZS3R0lGdEhMVTlCV2s/Tutorial-Index.html")
    request = NSURLRequest.requestWithURL(url)
    self.view.loadRequest request

  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
