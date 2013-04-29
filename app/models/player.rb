class Player
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :player_name => :string, 
  :position => {:type => :string, :default => "Guard"}
  
  has_many :performances
  
end