# require neccesary files
require_relative "pokemon"

class Player
  attr_accessor :level
  attr_reader :name, :pokemon, :pokemon_name, :speed, :priority

  pokedex = Pokedex::POKEMONS
  # (Complete parameters)
  def initialize(name, pokemon, pokemon_name, level)
    # Complete this
    @name = name
    @pokemon = pokemon
    @pokemon_name = Pokemon.new(pokemon_name, pokemon, level)
  end
end

# Create a class Bot that inherits from Player and override the select_move method

class Bot < Player
  def initialize(level)
    pokedex = Pokedex::POKEMONS
    @name = "Random Person"
    @pokemon = pokedex.keys.sample
    @pokemon_name = Pokemon.new(@pokemon, @pokemon, level)
  end
end

class Brock < Player
  def initialize
    pokedex = Pokedex::POKEMONS
    @name = "Brock"
    @pokemon = pokedex["Onix"]
    @pokemon_name = Pokemon.new("Onix", "Onix", 10)
  end
end
