class Game < NanoStore::Model
  
  attribute :date_played
  attribute :team1
  attribute :team2
  
  class << self
    def create_new(team1, team2)
      obj = new(date_played: Time.now.strftime("%m-%d-%y, %l:%M %p"),
      team1: team1,
      team2: team2)
      obj.save
    end
  end
  
  # Invoke this after creating a game so that we can create and index the individual Statlines associated with the game 
  def create_statlines
    players_teams = []
    players_teams[0] = self.team1
    players_teams[1] = self.team2
    answer = [[],[]]
    
    players_teams.each_with_index do |teams, idx|
      teams.each_with_index do |player_name, index|
        # Uses an array because for some reason they do not take more than 2 arguments
        answer[idx] << Statline.create_new(player_name, [self.key, self.date_played])
      end
    end
    return answer
  end
  
  def return_statlines
    return Statline.find(:game_key, NSFEqualTo, self.key)
  end

  
  # Setter method to help set up the right array structure for a sectioned table
  def create_index
    players_teams = []
    players_teams[0] = self.team1
    players_teams[1] = self.team2    
    return players_teams
  end
  
end