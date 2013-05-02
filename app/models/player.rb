class Player
  include MotionModel::Model
  # include MotionModel::ArrayModelAdapter
  
  columns :player_name => {:type => :string, :default => "Johnny Appleseed"},
  :position => {:type => :string, :default => "Guard"},
  :image => {:type => :string, :default => "blank_profile.png"} 
  
  has_many :performances
  
  def return_performances
    return Performance.where(:player_dat).eq(self.id).all.reverse
  end
  
  def average(stat)
    avge = 0
    performances = self.return_performances
    if performances.count == 0
      return "n/a" 
    else
      performances.each do |perf|
        avge += perf.send(stat.to_sym)
      end
      return (avge/performances.count).to_f
    end
  end
    
end