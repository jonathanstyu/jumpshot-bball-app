class Player
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :player_name => :string, 
  :position => {:type => :string, :default => "Guard"}, 
  :team => :int, 
  :points => {:type => :int, :default => 0}, 
  :rebounds => {:type => :int, :default => 0}, 
  :assists => {:type => :int, :default => 0}, 
  :steals => {:type => :int, :default => 0}, 
  :blocks => {:type => :int, :default => 0}, 
  :made_field_goals => {:type => :int, :default => 0}, 
  :total_field_goals => {:type => :int, :default => 0}
  
  
end