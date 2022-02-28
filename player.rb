# require neccesary files
require_relative "pokemon.rb"

class Player
  attr_reader :name, :pokemon, :pokemon_name, :level, :speed, :priority
  attr_writer :level
  pokedex =  Pokedex::POKEMONS
  # (Complete parameters)
  def initialize(name, pokemon, pokemon_name, level)
    # Complete this
    @name = name
    @pokemon = pokemon
    @pokemon_name = Pokemon.new(pokemon_name, pokemon, level)
  end

  def select_move
    # Complete this
  end
end

# Create a class Bot that inherits from Player and override the select_move method

class Bot < Player
  def initialize(level)
    pokedex =  Pokedex::POKEMONS
    @name = "Random Person"
    @pokemon = pokedex.keys.sample
    @pokemon_name = Pokemon.new(@pokemon, @pokemon, level)
  end
end