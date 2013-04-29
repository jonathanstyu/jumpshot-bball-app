class Game
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :date_played => :date, 
  :team_1 => {:type => :array, :default => []}, 
  :team_2 => {:type => :array, :default => []}
  has_many :performances
  
  
end