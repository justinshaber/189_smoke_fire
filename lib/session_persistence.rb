ROUND_INFO = [
  {
    name: "Smoke or Fire",
    options: ["Smoke", "Fire"],
    rules: "Will the card be red or black?"
  },
  
  {
    name: "High or Low",
    options: ["High", "Low"],
    rules: "Will the card be higher or lower than your current card?"
  },
  
  {
    name: "In or Out",
    options: ["In", "Out", "On"],
    rules: "Will the card be inside or outside of your two cards?"
  },
  
  {
    name: "Suits",
    options: ["Heart", "Diamond", "Club", "Spade"],
    rules: "What will be the card's suit?"
  }
]

class GameSession
  def initialize(session)
    @session = session
    @session[:deck] ||= Deck.new
    @session[:players] ||= []
    @session[:round] ||= 1
  end
  
  def deck
    @session[:deck].deck
  end
  
  def players
    @session[:players]
  end
  
  def round
    @session[:round]
  end
  
  def add_player(name, point_type)
    @session[:players] << Player.new(name, point_type)
  end
end

class Deck
  attr_accessor :deck
  
  RANKS = ("2".."10").to_a + %w(J Q K A)
  SUITS = %w(h c d s)
  
  def initialize
    @deck = []
    build_deck
  end
  
  def build_deck
    @deck = RANKS.product(SUITS).shuffle
  end
end

class Player
  attr_accessor :name, :point_type, :point_total
  
  def initialize(name, point_type)
    @name = name
    @point_type = point_type
    @point_total = 0
  end
end