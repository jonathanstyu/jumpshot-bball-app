class ViewplayerViewController < UIViewController
  attr_accessor :player
  
  def viewDidLoad
    super
    self.title = "Profile"
    view.backgroundColor = 0xf4f4f4.uicolor
    layout_views
  end
  
  def initWithPlayer(player)
    initWithNibName(nil, bundle:nil)
    self.player = player
    self
  end

  def layout_views
    scr_width = view.bounds.width
    scr_height = view.bounds.height
    
    if Device.ipad?
      table_y = scr_width / 5
      name_font = :bold.uifont(30)
      header_font = :bold.uifont(28)
      subtitle_font = :bold.uifont(14)
      name_x = scr_width * 0.25
      pic_frame = CGRect.make(x: scr_width * 0.05, y: scr_width * 0.02, width: scr_width * 0.15, height: scr_width * 0.15)
    else
      table_y = scr_width / 3
      name_font = :bold.uifont(23)
      header_font = :bold.uifont(20)
      subtitle_font = :bold.uifont(11)
      name_x = scr_width * 0.3
      pic_frame = CGRect.make(x: scr_width * 0.05, y: scr_width * 0.05, width: scr_width * 0.25, height: scr_width * 0.25)
    end
    
    name_label = UILabel.new
    name_label.frame = CGRect.make(x: name_x, y:5, width: scr_width*0.95, height: scr_height * 0.07)
    name_label.text = player.player_name
    name_label.font = name_font
    name_label.backgroundColor = :clear.uicolor 
    view << name_label
    
    @pic_view = UIImageView.new 
    @pic_view.frame = pic_frame 
    @pic_view.image = "#{player.image}".uiimage
    # @pic_view.on(:touch) {find_new_pic}
    view << @pic_view
    
    @pts_avg_label = UILabel.new
    @pts_avg_label.frame = CGRect.make(x: scr_width * 0.45, y: scr_height * 0.08, width: scr_width / 6, height: 40)
    @pts_avg_label.textAlignment = :center.uialignment
    @pts_avg_label.backgroundColor = :clear.uicolor 
    @pts_avg_label.text = "#{player.average(:points)}"
    @pts_avg_label.font = header_font
    view << @pts_avg_label
    
    @reb_avg_label = UILabel.new
    @reb_avg_label.frame = @pts_avg_label.frame.beside
    @reb_avg_label.textAlignment = :center.uialignment
    @reb_avg_label.backgroundColor = :clear.uicolor 
    @reb_avg_label.text = "#{player.average(:rebounds)}"
    @reb_avg_label.font = header_font
    view << @reb_avg_label
    
    @ast_avg_label = UILabel.new
    @ast_avg_label.textAlignment = :center.uialignment
    @ast_avg_label.frame = @reb_avg_label.frame.beside
    @ast_avg_label.backgroundColor = :clear.uicolor 
    @ast_avg_label.text = "#{player.average(:assists)}"
    @ast_avg_label.font = header_font
    view << @ast_avg_label
    
    pt_subtitle = UILabel.new
    pt_subtitle.textAlignment = :center.uialignment
    pt_subtitle.frame = @pts_avg_label.frame.below.height(17)
    pt_subtitle.font = subtitle_font
    pt_subtitle.backgroundColor = :clear.uicolor
    pt_subtitle.text = "pts/game"
    view << pt_subtitle

    rb_subtitle = UILabel.new
    rb_subtitle.textAlignment = :center.uialignment
    rb_subtitle.frame = @reb_avg_label.frame.below.height(17)
    rb_subtitle.font = subtitle_font
    rb_subtitle.backgroundColor = :clear.uicolor
    rb_subtitle.text = "reb/game"
    view << rb_subtitle

    at_subtitle = UILabel.new
    at_subtitle.textAlignment = :center.uialignment
    at_subtitle.frame = @ast_avg_label.frame.below.height(17)
    at_subtitle.font = subtitle_font
    at_subtitle.backgroundColor = :clear.uicolor
    at_subtitle.text = "ast/game"
    view << at_subtitle
    
    @performance_table = UITableView.new 
    @performance_table.frame = CGRect.make(x: 0, y: table_y, width: scr_width, height: scr_height - name_label.frame.height)
    @performance_table.delegate = @performance_table.dataSource = self
    @performance_table.rowHeight = 130
    @performance_table.backgroundColor = :white.uicolor
    @performance_table.addPullToRefreshWithActionHandler(
    Proc.new do 
      loadData
    end
    )
    view << @performance_table
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @performances = player.return_performances
    return @performances.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = ProfileCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
    performance = @performances[indexPath.row]

    cell.date_label.text = performance.game_name
    cell.points_label.text = performance.points.to_s
    cell.fg_label.text = "#{performance.made_field_goals.to_s}/#{performance.total_field_goals.to_s}"
    cell.rebounds_label.text = performance.rebounds.to_s
    cell.assists_label.text = performance.assists.to_s
    cell.steals_label.text = performance.steals.to_s
    cell.blocks_label.text = performance.blocks.to_s
    
    cell
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
  
  def loadData
    Dispatch::Queue.main.after(2) {
      @performance_table.reloadData
      @performance_table.pullToRefreshView.stopAnimating
      @pts_avg_label.text = "#{player.average(:points)}"
      @reb_avg_label.text = "#{player.average(:rebounds)}"
      @ast_avg_label.text = "#{player.average(:assists)}"
    }
  end
  
  def find_new_pic
    puts "hello"
  end
  
end
