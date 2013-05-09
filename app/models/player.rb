class Player < NanoStore::Model
  
  attribute :name
  
  class << self
    def create_new name
      obj = new(name: name)
      obj.save 
    end
  end
  
  def return_statlines
    return Statline.find(:player_key, NSFEqualTo, self.name)
  end
  
  def average(stat)
    avge = 0
    statlines = self.return_statlines
    if statlines.count == 0
      return "n/a" 
    else
      statlines.each do |perf|
        avge += perf.send(stat.to_sym)
      end
      return (avge.to_f/statlines.count.to_f).to_f.round(1)
    end
  end
  
  #   def export_data
  #     final = "This is the player profile for #{self.player_name}:\n\n"
  #     performances = self.return_performances
  #     if performances.count == 0
  #       "No games found!\n\n"
  #     else
  #       performances.each do |perf|
  #         final << "#{perf.game_name}:\n\n "
  #         final << perf.export_line
  #       end
  #     end
  #     final << "\n\nThanks for using JumpShot!"
  #   end
  
end