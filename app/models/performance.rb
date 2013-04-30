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
  :made_field_goals => {:type => :int, :default => 0}, 
  :total_field_goals => {:type => :int, :default => 0}
  
  belongs_to :player
  belongs_to :game
  
  def made_fg
    self.total_field_goals += 1
    self.made_field_goals += 1 
    self.points += 2
  end
  
  def made_3fg
    self.total_field_goals += 1
    self.made_field_goals += 1 
    self.points += 3
  end
  
end