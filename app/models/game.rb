class Game
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns :date_played => :date, 
  :team_1 => {:type => :array, :default => []}, 
  :team_2 => {:type => :array, :default => []}
  has_many :performances
  
  def tally_scores
    scores = []
    @players_teams = []
    @players_teams[0] = self.team_1
    @players_teams[1] = self.team_2
    
    @players_teams.each_with_index do |team, index|
      team.each do |player|
        individual_performance = Performance.where(:player_id).eq(player.id).and(:game_id).eq(self.id).first
        scores[index] += individual_performance.points
      end
    end
    return scores
  end
  
  def create_performances
    @players_teams = []
    @players_teams[0] = self.team_1
    @players_teams[1] = self.team_2
    
    @players_teams.each do |teams|
      teams.each do |player|
        self.performances.create(:player_id => player.id, :game_id => self.id)
      end
    end
  end
  
  def create_index
    @players_teams = []
    @players_teams[0] = self.team_1
    @players_teams[1] = self.team_2
    return @players_teams
  end
  
  def return_team_performances
    @players_teams = []
    @players_teams[0] = self.team_1
    @players_teams[1] = self.team_2
    team_performances = [[],[]]
    
    @players_teams.each_with_index do |teams, index|
      teams.each do |player|
        team_performances[index] << self.performances.where(:player_id).eq(player.id).first
      end
    end
    return team_performances
  end
  
end