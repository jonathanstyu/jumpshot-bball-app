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
    @points_label.textAlignment = :center.uialignment
    @points_label.font = :bold.uifont(27)
    @points_label.backgroundColor = :clear.uicolor
    @points_label.textColor = 0x9494bf.uicolor
    
    @rebounds_label = UILabel.new
    @rebounds_label.textAlignment = :center.uialignment
    @rebounds_label.font = :bold.uifont(27)
    @rebounds_label.backgroundColor = :clear.uicolor
    @rebounds_label.textColor = 0xc3b690.uicolor
    
    @assists_label = UILabel.new
    @assists_label.textAlignment = :center.uialignment
    @assists_label.font = :bold.uifont(27)
    @assists_label.backgroundColor = :clear.uicolor
    @assists_label.textColor = 0x8dbfab.uicolor
    
    @info_label = UILabel.new
    @info_label.textAlignment = :left.uialignment
    @info_label.font = :bold.uifont(9)
    @info_label.backgroundColor = :clear.uicolor
    @info_label.textColor = 0x9494bf.uicolor
    @info_label.text = "points"
    
    @infoR_label = UILabel.new
    @infoR_label.textAlignment = :left.uialignment
    @infoR_label.font = :bold.uifont(8.5)
    @infoR_label.backgroundColor = :clear.uicolor
    @infoR_label.textColor = 0xc3b690.uicolor
    @infoR_label.text = "rebounds"
    
    @infoA_label = UILabel.new
    @infoA_label.textAlignment = :left.uialignment
    @infoA_label.font = :bold.uifont(9)
    @infoA_label.backgroundColor = :clear.uicolor
    @infoA_label.textColor = 0x8dbfab.uicolor
    @infoA_label.text = "assists"
    

    self.contentView << @name_label
    self.contentView << @position_label 
    self.contentView << @points_label
    self.contentView << @rebounds_label 
    self.contentView << @assists_label
    
    self.contentView << @info_label
    self.contentView << @infoR_label
    self.contentView << @infoA_label
    
    self 
  end
  
  def layoutSubviews
    super
    
    contentRect = self.contentView.bounds
    boundsX = contentRect.origin.x
    widthTable = self.contentView.bounds.width
    cellWidth = (widthTable) / 2
    name_frame = CGRect.make(x: boundsX+10,y: 5, width: cellWidth, height: 25)
    points_frame = CGRect.make(x: cellWidth-4,y: 12, width: cellWidth/3, height: 22)
    
    @name_label.frame = name_frame
    @position_label.frame = name_frame.below
    @points_label.frame = points_frame
    @rebounds_label.frame = @points_label.frame.beside 
    @assists_label.frame = @rebounds_label.frame.beside.right(4)
    @info_label.frame = @points_label.frame.below(4)
    @infoR_label.frame = @rebounds_label.frame.below(4)
    @infoA_label.frame = @assists_label.frame.below(4)
    
  end
  
end