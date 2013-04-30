class Player
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :player_name => {:type => :string, :default => "Johnny Appleseed"},
  :position => {:type => :string, :default => "Guard"}
  
  has_many :performances
  
end