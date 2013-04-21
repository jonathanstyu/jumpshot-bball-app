class Game
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :team1 => :string, :team2 => :string
  has_many :players
  
end