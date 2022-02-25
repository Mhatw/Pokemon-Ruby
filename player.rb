# require neccesary files
require_relative "pokemon.rb"

class Player
  attr_reader :name, :pokemon, :pokemon_name
  # (Complete parameters)
  def initialize(name, pokemon, pokemon_name)
    # Complete this
    pokedex =  Pokedex::POKEMONS
    @name = name
    @pokemon = pokemon
    @pokemon_name = Pokemon.new(pokemon_name, pokemon)
  end

  def select_move
    # Complete this
  end
end

# Create a class Bot that inherits from Player and override the select_move method

class Bot < Player
  def initialize
    pokedex =  Pokedex::POKEMONS
    @name = "Random Person"
    @pokemon = pokedex.keys.sample
  end

end