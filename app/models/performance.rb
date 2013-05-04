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
  :fg => {:type => :array, :default => [0,0]},
  :game_name => {:type => :string, :default => "Game Deleted"},
  :threefg => {:type => :array, :default => [0,0]}, 
  :ft => {:type => :array, :default => [0,0]}, 
  :fouls => {:type => :int, :default => 0}
  
  belongs_to :game
  
  def made_fg
    self.fg[1] += 1
    self.fg[0] += 1 
    if App::Persistence['12pts'] == true
      self.points += 2
    else
      self.points += 1
    end
  end
  
  def missed_fg
    self.fg[1] += 1
  end
  
  def made_3fg
    self.threefg[1] += 1
    self.threefg[0] += 1 
    self.fg[1] += 1
    self.fg[0] += 1 
    if App::Persistence['12pts'] == true
      self.points += 3
    else
      self.points += 2
    end
  end
  
  def missed_3fg
    self.threefg[1] += 1
    self.fg[1] += 1
  end
  
  def made_ft
    self.ft[0] += 1
    self.ft[1] += 1 
    self.points += 1
  end
  
  def missed_ft
    self.ft[1] += 1 
  end
  
end