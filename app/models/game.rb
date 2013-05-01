class Game
  include MotionModel::Model
  # include MotionModel::ArrayModelAdapter
  
  columns :date_played => {:type => :string, :default => Time.new.strftime("%m-%d-%Y")}, 
  :team_1 => {:type => :array, :default => []}, 
  :team_2 => {:type => :array, :default => []}
  has_many :performances
  
  # Helps calculate the point total for each team 
  def tally_points(team_name)
    total = 0
    if team_name == 1
      team_1.each do |player|
        individual_performance = self.performances.where(:player_dat).eq(player.id).first
        total += individual_performance.points
      end
    else
      team_2.each do |player|
        individual_performance = self.performances.where(:player_dat).eq(player.id).first
        total += individual_performance.points
      end
    end
    return total
  end
  
  # setter method to help create subservient performances under an individual game
  def create_performances
    @players_teams = []
    @players_teams[0] = self.team_1
    @players_teams[1] = self.team_2
    
    @players_teams.each do |teams|
      teams.each do |player|
        self.performances.create(:player_dat => player.id, :game_dat => self.id, :game_name => self.date_played)
      end
    end
  end
  
  # setter method to help set up the right array structure for a sectioned table
  def create_index
    @players_teams = []
    @players_teams[0] = self.team_1
    @players_teams[1] = self.team_2
    return @players_teams
  end
    
end