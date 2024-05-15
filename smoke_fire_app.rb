require 'sinatra'
require 'sinatra/content_for' # take away if not using
require 'tilt/erubis'

require_relative 'lib/session_persistence'


configure(:development) do
  require 'sinatra/reloader'
  also_reload './lib/session_persistence.rb'
end

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
  set :erb, :escape_html => true
end

before do
  @game = GameSession.new(session)
  @deck = @game.deck
  @players = @game.players
  @round = @game.round
end

helpers do
  def round_number
    @round
  end
  
  def round_name
    ROUND_INFO[round_number - 1][:name]
  end
  
  def round_options
     ROUND_INFO[round_number - 1][:options]
  end
end

get "/" do
  redirect "/setup"
end

get "/setup" do
  erb :setup, layout: :layout
end

get "/game" do
  erb :game_board, layout: :layout
end

post "/add_player" do
  name = params[:player_name]
  point_type = params[:point_type]
  @game.add_player(name, point_type)
  redirect "/setup"
end