class Team
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :team_name => :string, :number_of_players => :int
  
end