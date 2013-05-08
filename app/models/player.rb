class Player
  include MotionModel::Model
  # include MotionModel::ArrayModelAdapter
  
  columns :player_name => {:type => :string, :default => "Johnny Appleseed"},
  :email => {:type => :string, :default => "Blank"},
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
      return (avge.to_f/performances.count.to_f).to_f.round(1)
    end
  end
  
  def export_data
    final = "This is the player profile for #{self.player_name}:\n\n"
    performances = self.return_performances
    if performances.count == 0
      "No games found!\n\n"
    else
      performances.each do |perf|
        final << "#{perf.game_name}:\n\n "
        final << perf.export_line
      end
    end
    final << "\n\nThanks for using JumpShot!"
  end
    
end