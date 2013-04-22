class PlayerCell < UITableViewCell
  
  attr_accessor :name_label
  attr_accessor :position_label
  attr_accessor :points_label
  attr_accessor :rebounds_label
  attr_accessor :assists_label
  
  # Reference for how these cells were programmatically set up >> https://gist.github.com/adelevie/4098535
  
  def createLabels
    @name_label = UILabel.new
    @name_label.textAlignment = :left.uialignment
    @name_label.font = :bold.uifont(17)
    @name_label.textColor = :white.uicolor
    @name_label.backgroundColor = :clear.uicolor
  
    @position_label = UILabel.new
    @position_label.textAlignment = :left.uialignment
    @position_label.font = :bold.uifont(11)
    @position_label.backgroundColor = :clear.uicolor
    @position_label.textColor = :white.uicolor
    
    @points_label = UILabel.new
    @points_label.textAlignment = :left.uialignment
    @points_label.font = :bold.uifont(19)
    @points_label.backgroundColor = :clear.uicolor
    @points_label.textColor = :white.uicolor
    
    @rebounds_label = UILabel.new
    @rebounds_label.textAlignment = :left.uialignment
    @rebounds_label.font = :bold.uifont(19)
    @rebounds_label.backgroundColor = :clear.uicolor
    @rebounds_label.textColor = :white.uicolor
    
    @assists_label = UILabel.new
    @assists_label.textAlignment = :left.uialignment
    @assists_label.font = :bold.uifont(19)
    @assists_label.backgroundColor = :clear.uicolor
    @assists_label.textColor = :white.uicolor
    

    self.contentView << @name_label
    self.contentView << @position_label 
    self.contentView << @points_label
    self.contentView << @rebounds_label 
    self.contentView << @assists_label
    
    self 
  end
  
  def layoutSubviews
    super
    
    contentRect = self.contentView.bounds
    boundsX = contentRect.origin.x
    widthTable = self.contentView.bounds.width
    cellWidth = (widthTable) / 2
    name_frame = CGRect.make(x: boundsX+10,y: 5, width: cellWidth, height: 25)
    
    @name_label.frame = name_frame
    @position_label.frame = name_frame.below
    @points_label.frame = name_frame.beside(10).width(cellWidth/3)
    @rebounds_label.frame = @points_label.frame.beside 
    @assists_label.frame = @rebounds_label.frame.beside
    
  end
  
end