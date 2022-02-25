# require neccesary files
require_relative "game"
class Player
  attr_reader :name, :pokemon, :pokemon_name
  # (Complete parameters)
  def initialize(name, pokemon, pokemon_name)
    # Complete this
    @name = name
    @pokemon = pokemon
    @pokemon_name = pokemon_name
  end

  def select_move
    # Complete this
  end
end

# Create a class Bot that inherits from Player and override the select_move method
