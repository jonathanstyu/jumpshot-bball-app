class Game
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :date_played => :date, 
  :team_1 => :array, 
  :team_2 => :array
  
end