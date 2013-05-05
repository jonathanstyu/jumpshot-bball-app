class IndexCell < UITableViewCell
  attr_accessor :ptsaverage
  attr_accessor :rebaverage
  attr_accessor :astaverage
  attr_accessor :name_label
  attr_accessor :info_label
  
  def createLabels
    if Device.ipad?
      name_font = :bold.uifont(22) 
      digit_font = :italic.uifont(17)
      subtitle_font = :bold.uifont(12)
    else
      name_font = :bold.uifont(18)
      digit_font = :italic.uifont(14)
      subtitle_font = :bold.uifont(9)
    end
    
    @name_label = UILabel.new
    @name_label.textAlignment = :left.uialignment
    @name_label.font = name_font
    @name_label.textColor =  :black.uicolor
    @name_label.backgroundColor = :clear.uicolor
    self.contentView << @name_label    
    
    @ptsaverage = UILabel.new
    @ptsaverage.textAlignment = :left.uialignment
    @ptsaverage.font = digit_font
    @ptsaverage.textColor =  :black.uicolor
    @ptsaverage.backgroundColor = :clear.uicolor
    self.contentView << @ptsaverage

    @rebaverage = UILabel.new
    @rebaverage.textAlignment = :left.uialignment
    @rebaverage.font = digit_font
    @rebaverage.textColor =  :black.uicolor
    @rebaverage.backgroundColor = :clear.uicolor
    self.contentView << @rebaverage

    @astaverage = UILabel.new
    @astaverage.textAlignment = :left.uialignment
    @astaverage.font = digit_font
    @astaverage.textColor =  :black.uicolor
    @astaverage.backgroundColor = :clear.uicolor
    self.contentView << @astaverage
    
    @info_label = UILabel.new
    @info_label.textAlignment = :center.uialignment
    @info_label.font = digit_font
    @info_label.textColor =  :black.uicolor
    @info_label.backgroundColor = :clear.uicolor
    self.contentView << @info_label

  end
  
  def layoutSubviews
    super
    
    widthTable = self.contentView.bounds.width
    
    @name_label.frame = CGRect.make(x: 15, y: 5, width: widthTable / 2, height: 25)
    @info_label.frame = CGRect.make(x: widthTable/4, y: 35, width: widthTable / 5.5, height: 25)
    @ptsaverage.frame = @info_label.frame.beside
    @rebaverage.frame = @ptsaverage.frame.beside
    @astaverage.frame = @rebaverage.frame.beside
    
    
  end
  
end