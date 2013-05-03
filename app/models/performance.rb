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
  :made_field_goals => {:type => :int, :default => 0}, 
  :total_field_goals => {:type => :int, :default => 0},
  :game_name => {:type => :string, :default => "Game Deleted"},
  :made_3fg => {:type => :int, :default => 0}, 
  :total_3fg => {:type => :int, :default => 0},
  :made_ft => {:type => :int, :default => 0}, 
  :total_ft => {:type => :int, :default => 0},
  :fouls => {:type => :int, :default => 0}
  
  belongs_to :player
  belongs_to :game
  
  def made_fg
    self.total_field_goals += 1
    self.made_field_goals += 1 
    if App::Persistence['12pts'] == true
      self.points += 2
    else
      self.points += 1
    end
  end
  
  def made_3fg
    self.total_field_goals += 1
    self.made_field_goals += 1 
    if App::Persistence['12pts'] == true
      self.points += 3
    else
      self.points += 2
    end

  end
  
  def made_ft
    self.total_ft += 1
    self.made_ft += 1 
    self.points += 1
  end
  
end