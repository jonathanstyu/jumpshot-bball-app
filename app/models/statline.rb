class Statline < NanoStore::Model
  
  attribute :player_key
  attribute :game_key
  attribute :game_name
  attribute :points
  attribute :rebounds
  attribute :assists
  attribute :steals
  attribute :blocks
  attribute :fouls
  attribute :turnovers
  attribute :fg_m
  attribute :fg_a
  attribute :threefg_m
  attribute :threefg_a
  attribute :ft_m
  attribute :ft_a
  attribute :min
  
  class << self
    def create_new baller_num, game_num
      obj = new(player_key: baller_num, 
      game_key: game_num,
      game_name: "Blank", 
      points: 0,
      rebounds: 0,
      assists: 0,
      steals: 0,
      blocks: 0,
      fouls: 0,
      turnovers: 0,
      fg_m: 0,
      fg_a: 0,
      threefg_m: 0,
      threefg_a: 0,
      ft_m: 0,
      ft_a: 0,
      min: 0
      )
      obj.save
    end
  end

  def made_fg
    self.fg_m += 1
    self.fg_a += 1
    if App::Persistence['12pts'] == true
      self.points += 2
    else
      self.points += 1
    end
    self.save
  end
  
  def missed_fg
    self.fg_a += 1
    self.save
  end
  
  def made_3fg
    self.fg_m += 1
    self.fg_a += 1
    self.threefg_m += 1
    self.threefg_a += 1
    if App::Persistence['12pts'] == true
      self.points += 3
    else
      self.points += 2
    end
    self.save
  end
  
  def missed_3fg
    self.fg_a += 1
    self.threefg_a += 1
    self.save
  end
  
  def made_ft
    self.ft_a += 1
    self.ft_m += 1
    self.points += 1
    self.save
  end
  
  def missed_ft
    self.ft_a +=1 
    self.save
  end
  
  def increment(stat)
    case stat
    when 'rebounds'
      self.rebounds += 1
    when 'assists'
      self.assists += 1
    when 'steals'
      self.steals += 1
    when 'blocks'
      self.blocks += 1
    when 'fouls'
      self.fouls += 1
    when 'turnovers'
      self.turnovers += 1
    else
      raise 'error, bad input'
    end
    self.save
  end
  
  # def export_line
  #   player = Player.where(:id).eq(self.player_dat).first
  #   data_row = "#{player.player_name}: #{self.points} points, #{self.rebounds} rebounds, #{self.assists} assists, #{self.steals} steals, and #{self.blocks} blocks, #{self.turnovers} turnovers, #{self.fouls} fouls, #{self.fg} fg%, #{self.threefg} 3fg%, #{self.ft} ft%"
  #   return data_row
  # end
  
end