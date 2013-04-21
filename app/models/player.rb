class Player
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :player_name => :string
  belongs_to :game
  
end