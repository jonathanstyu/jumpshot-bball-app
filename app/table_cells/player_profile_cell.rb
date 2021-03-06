class ProfileCell < UITableViewCell
  attr_accessor :date_label
  attr_accessor :points_label
  attr_accessor :fg_label
  attr_accessor :rebounds_label
  attr_accessor :assists_label
  attr_accessor :steals_label
  attr_accessor :blocks_label
  attr_accessor :ft_label
  attr_accessor :fg3_label
  attr_accessor :to_label
  attr_accessor :f_label
  
  def createLabels
    if Device.ipad?
      name_font = :bold.uifont(22) 
      digit_font = :bold.uifont(30)
      subtitle_font = :bold.uifont(12)
    else
      name_font = :bold.uifont(15)
      digit_font = :bold.uifont(18)
      subtitle_font = :bold.uifont(9)
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
    @fg_label.font = digit_font
    @fg_label.backgroundColor = :clear.uicolor
    @fg_label.textColor = :black.uicolor
    
    @fg3_label = UILabel.new
    @fg3_label.textAlignment = :center.uialignment
    @fg3_label.font = digit_font
    @fg3_label.backgroundColor = :clear.uicolor
    @fg3_label.textColor = :black.uicolor
    
    @ft_label = UILabel.new
    @ft_label.textAlignment = :center.uialignment
    @ft_label.font = digit_font
    @ft_label.backgroundColor = :clear.uicolor
    @ft_label.textColor = :black.uicolor
    
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
    
    @to_label = UILabel.new
    @to_label.textAlignment = :center.uialignment
    @to_label.font = digit_font
    @to_label.backgroundColor = :clear.uicolor
    @to_label.textColor = :black.uicolor
    
    @f_label = UILabel.new
    @f_label.textAlignment = :center.uialignment
    @f_label.font = digit_font
    @f_label.backgroundColor = :clear.uicolor
    @f_label.textColor = :black.uicolor    
    
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
    @infoR_label.text = "rebs"
    
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
    @infoF_label.text = "FGs"
    
    @info3F_label = UILabel.new
    @info3F_label.textAlignment = :center.uialignment
    @info3F_label.font = subtitle_font
    @info3F_label.backgroundColor = :clear.uicolor
    @info3F_label.textColor = :black.uicolor
    @info3F_label.text = "3FGs"
    
    @infoft_label = UILabel.new
    @infoft_label.textAlignment = :center.uialignment
    @infoft_label.font = subtitle_font
    @infoft_label.backgroundColor = :clear.uicolor
    @infoft_label.textColor = :black.uicolor
    @infoft_label.text = "FTs"
    
    @infoTO_label = UILabel.new
    @infoTO_label.textAlignment = :center.uialignment
    @infoTO_label.font = subtitle_font
    @infoTO_label.backgroundColor = :clear.uicolor
    @infoTO_label.textColor = :black.uicolor
    @infoTO_label.text = "TOs"
    
    @infoFO_label = UILabel.new
    @infoFO_label.textAlignment = :center.uialignment
    @infoFO_label.font = subtitle_font
    @infoFO_label.backgroundColor = :clear.uicolor
    @infoFO_label.textColor = :black.uicolor
    @infoFO_label.text = "fouls"
    
    self.contentView << @date_label 
    
    self.contentView << @points_label
    self.contentView << @fg_label
    self.contentView << @fg3_label
    self.contentView << @ft_label
    self.contentView << @rebounds_label 
    self.contentView << @assists_label
    self.contentView << @steals_label
    self.contentView << @blocks_label
    self.contentView << @to_label
    self.contentView << @f_label
    
    self.contentView << @info_label
    self.contentView << @infoR_label
    self.contentView << @infoA_label
    self.contentView << @infoS_label
    self.contentView << @infoB_label
    self.contentView << @infoF_label
    self.contentView << @info3F_label
    self.contentView << @infoft_label
    self.contentView << @infoTO_label
    self.contentView << @infoFO_label
    
    self 
  end
  
  def layoutSubviews
    super
    
    contentRect = self.contentView.bounds
    boundsX = contentRect.origin.x
    widthTable = self.contentView.bounds.width
    colWidth = (widthTable) / 8
    date_frame = CGRect.make(x: boundsX + 15, y: 10, width: widthTable/4, height: 50)
    points_frame = CGRect.make(x: widthTable * 0.36, y: 10, width: colWidth, height: 25)
    
    @date_label.frame = date_frame
    @points_label.frame = points_frame
    @fg_label.frame = @info_label.frame.below(15).height(25)
    @fg3_label.frame = points_frame.beside
    @ft_label.frame = @info3F_label.frame.below(15).height(25)
    @rebounds_label.frame = @fg3_label.frame.beside
    @assists_label.frame = @rebounds_label.frame.beside
    @steals_label.frame = @infoR_label.frame.below(15).height(25)
    @blocks_label.frame = @infoA_label.frame.below(15).height(25)
    @to_label.frame = @assists_label.frame.beside
    @f_label.frame = @infoTO_label.frame.below(15).height(25)
    
    @info_label.frame = @points_label.frame.below(4).height(16)
    @infoF_label.frame = @fg_label.frame.below(4).height(16)
    @infoR_label.frame = @rebounds_label.frame.below(4).height(16)
    @infoA_label.frame = @assists_label.frame.below(4).height(16)
    @infoS_label.frame = @steals_label.frame.below(4).height(16)
    @infoB_label.frame = @blocks_label.frame.below(4).height(16)
    @info3F_label.frame = @fg3_label.frame.below(4).height(16)
    @infoft_label.frame = @ft_label.frame.below(4).height(16)
    @infoTO_label.frame = @to_label.frame.below(4).height(16)
    @infoFO_label.frame = @f_label.frame.below(4).height(16)
    
    
  end
  
end