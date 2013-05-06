class Performance
  include MotionModel::Model
  # include MotionModel::ArrayModelAdapter
  
  columns :player_dat => {:type => :int, :default => 0}, 
  :game_dat => {:type => :int, :default => 0}, 
  :points => {:type => :int, :default => 0}, 
  :rebounds => {:type => :int, :default => 0}, 
  :assists => {:type => :int, :default => 0}, 
  :steals => {:type => :int, :default => 0}, 
  :blocks => {:type => :int, :default => 0}, 
  :turnovers => {:type => :int, :default => 0}, 
  :fg => {:type => :string, :default => "0-0"},
  :game_name => {:type => :string, :default => "Game Deleted"},
  :threefg => {:type => :string, :default => "0-0"}, 
  :ft => {:type => :string, :default => "0-0"}, 
  :fouls => {:type => :int, :default => 0}
  
  belongs_to :game
  
  def made_fg
    digit = self.fg.split("-")
    digit[1] = digit[1].to_i + 1
    digit[0] = digit[0].to_i + 1
    if App::Persistence['12pts'] == true
      self.points += 2
    else
      self.points += 1
    end
    self.fg = digit.join("-")
  end
  
  def missed_fg
    digit = self.fg.split("-")
    digit[1] = digit[1].to_i + 1
    self.fg = digit.join("-")
  end
  
  def made_3fg
    digit3 = self.threefg.split("-")
    digit3[1] = digit3[1].to_i + 1
    digit3[0] = digit3[0].to_i + 1
      
    digit = self.fg.split("-")
    digit[1] = digit[1].to_i + 1
    digit[0] = digit[0].to_i + 1
    if App::Persistence['12pts'] == true
      self.points += 3
    else
      self.points += 2
    end
    self.threefg = digit3.join("-")
    self.fg = digit.join("-")
  end
  
  def missed_3fg
    digit3 = self.threefg.split("-")
    digit3[1] = digit3[1].to_i + 1
    digit = self.fg.split("-")
    digit[1] = digit[1].to_i + 1
    self.fg = digit.join("-")
    self.threefg = digit3.join("-")
  end
  
  def made_ft
    digit = self.ft.split("-")
    digit[1] = digit[1].to_i + 1
    digit[0] = digit[0].to_i + 1
    self.points += 1
    self.ft = digit.join("-")
  end
  
  def missed_ft
    digit = self.ft.split("-")
    digit[1] = digit[1].to_i + 1
    self.ft = digit.join("-")
  end
  
  def export_line
    player = Player.where(:id).eq(self.player_dat).first
    data_row = "#{player.player_name}: #{self.points} points, #{self.rebounds} rebounds, #{self.assists} assists, #{self.steals} steals, and #{self.blocks} blocks, #{self.turnovers} turnovers, #{self.fouls} fouls, #{self.fg} fg%, #{self.threefg} 3fg%, #{self.ft} ft%"
    return data_row
  end
  
end