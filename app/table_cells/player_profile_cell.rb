class ProfileCell < UITableViewCell
  attr_accessor :date_label
  attr_accessor :points_label
  attr_accessor :fg_label
  attr_accessor :rebounds_label
  attr_accessor :assists_label
  attr_accessor :steals_label
  attr_accessor :blocks_label
  
  def createLabels
    if Device.ipad?
      name_font = :bold.uifont(22) 
      digit_font = :bold.uifont(30)
      subtitle_font = :bold.uifont(12)
    else
      name_font = :bold.uifont(17)
      digit_font = :bold.uifont(25)
      subtitle_font = :bold.uifont(11)
    end
        
    @date_label = UILabel.new
    @date_label.textAlignment = :left.uialignment
    @date_label.font = name_font
    @date_label.textColor =  :black.uicolor
    @date_label.backgroundColor = :clear.uicolor
  
    @points_label = UILabel.new
    @points_label.textAlignment = :center.uialignment
    @points_label.font = digit_font
    @points_label.backgroundColor = :clear.uicolor
    @points_label.textColor = :black.uicolor
    
    @fg_label = UILabel.new
    @fg_label.textAlignment = :center.uialignment
    @fg_label.font = :bold.uifont(22)
    @fg_label.backgroundColor = :clear.uicolor
    @fg_label.textColor = :black.uicolor
    
    @rebounds_label = UILabel.new
    @rebounds_label.textAlignment = :center.uialignment
    @rebounds_label.font = digit_font
    @rebounds_label.backgroundColor = :clear.uicolor
    @rebounds_label.textColor = :black.uicolor
    
    @assists_label = UILabel.new
    @assists_label.textAlignment = :center.uialignment
    @assists_label.font = digit_font
    @assists_label.backgroundColor = :clear.uicolor
    @assists_label.textColor = :black.uicolor
    
    @steals_label = UILabel.new
    @steals_label.textAlignment = :center.uialignment
    @steals_label.font = digit_font
    @steals_label.backgroundColor = :clear.uicolor
    @steals_label.textColor = :black.uicolor
    
    @blocks_label = UILabel.new
    @blocks_label.textAlignment = :center.uialignment
    @blocks_label.font = digit_font
    @blocks_label.backgroundColor = :clear.uicolor
    @blocks_label.textColor = :black.uicolor
    
    @info_label = UILabel.new
    @info_label.textAlignment = :center.uialignment
    @info_label.font = subtitle_font
    @info_label.backgroundColor = :clear.uicolor
    @info_label.textColor = :black.uicolor
    @info_label.text = "points"
    
    @infoR_label = UILabel.new
    @infoR_label.textAlignment = :center.uialignment
    @infoR_label.font = subtitle_font
    @infoR_label.backgroundColor = :clear.uicolor
    @infoR_label.textColor = :black.uicolor
    @infoR_label.text = "rebounds"
    
    @infoA_label = UILabel.new
    @infoA_label.textAlignment = :center.uialignment
    @infoA_label.font = subtitle_font
    @infoA_label.backgroundColor = :clear.uicolor
    @infoA_label.textColor = :black.uicolor
    @infoA_label.text = "assists"
    
    @infoS_label = UILabel.new
    @infoS_label.textAlignment = :center.uialignment
    @infoS_label.font = subtitle_font
    @infoS_label.backgroundColor = :clear.uicolor
    @infoS_label.textColor = :black.uicolor
    @infoS_label.text = "steals"
    
    @infoB_label = UILabel.new
    @infoB_label.textAlignment = :center.uialignment
    @infoB_label.font = subtitle_font
    @infoB_label.backgroundColor = :clear.uicolor
    @infoB_label.textColor = :black.uicolor
    @infoB_label.text = "blocks"
    
    @infoF_label = UILabel.new
    @infoF_label.textAlignment = :center.uialignment
    @infoF_label.font = subtitle_font
    @infoF_label.backgroundColor = :clear.uicolor
    @infoF_label.textColor = :black.uicolor
    @infoF_label.text = "FgA/FgM"
    
    @info3F_label = UILabel.new
    @info3F_label.textAlignment = :center.uialignment
    @info3F_label.font = subtitle_font
    @info3F_label.backgroundColor = :clear.uicolor
    @info3F_label.textColor = :black.uicolor
    @info3F_label.text = "3FgA/3FgM"
    

    self.contentView << @date_label 
    
    self.contentView << @points_label
    self.contentView << @fg_label
    self.contentView << @rebounds_label 
    self.contentView << @assists_label
    self.contentView << @steals_label
    self.contentView << @blocks_label
    
    self.contentView << @info_label
    self.contentView << @infoR_label
    self.contentView << @infoA_label
    self.contentView << @infoS_label
    self.contentView << @infoB_label
    self.contentView << @infoF_label
    
    self 
  end
  
  def layoutSubviews
    super
    
    contentRect = self.contentView.bounds
    boundsX = contentRect.origin.x
    widthTable = self.contentView.bounds.width
    colWidth = (widthTable) / 6
    date_frame = CGRect.make(x: boundsX + 15, y: 20, width: widthTable/3, height: 25)
    points_frame = CGRect.make(x: widthTable * 0.45, y: 10, width: colWidth, height: 25)
    
    @date_label.frame = date_frame
    @points_label.frame = points_frame
    @fg_label.frame = @info_label.frame.below(15).height(25)
    @rebounds_label.frame = points_frame.beside
    @assists_label.frame = @rebounds_label.frame.beside
    @steals_label.frame = @infoR_label.frame.below(15).height(25)
    @blocks_label.frame = @infoA_label.frame.below(15).height(25)
    
    @info_label.frame = @points_label.frame.below(4).height(20)
    @infoF_label.frame = @fg_label.frame.below(4).height(20)
    @infoR_label.frame = @rebounds_label.frame.below(4).height(20)
    @infoA_label.frame = @assists_label.frame.below(4).height(20)
    @infoS_label.frame = @steals_label.frame.below(4).height(20)
    @infoB_label.frame = @blocks_label.frame.below(4).height(20)
    
    
  end
  
end