class Player
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :player_name => :string, :position => {:type => :string, :default => "Guard"}, :points => {:type => :int, :default => 0}, :rebounds => {:type => :int, :default => 0}, :assists => {:type => :int, :default => 0}
  
  belongs_to :team
  
end