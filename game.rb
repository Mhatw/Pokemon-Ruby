# require neccesary files
require_relative "player"

class Game
  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user
    puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#

Hello there! Welcome to the world of POKEMON! My name is OAK!
People call me the POKEMON PROF!

This world is inhabited by creatures called POKEMON! For some
people, POKEMON are pets. Others use them for fights. Myself...
I study POKEMON as a profession.
First, what is your name?"
    print "> "
    name = gets.chomp
    while name.empty?
      print "> "
      name = gets.chomp
    end
    puts "Right! So your name is #{name.upcase}!
Your very own POKEMON legend is about to unfold! A world of
dreams and adventures with POKEMON awaits! Let's go!
Here, #{name.upcase}! There are 3 POKEMON here! Haha!
When I was young, I was a serious POKEMON trainer.
In my old age, I have only 3 left, but you can have one! Choose!

1. Bulbasaur    2. Charmander   3. Squirtle "
    print "> "
    pokemon = gets.chomp
    until pokemon == "Bulbasaur" || pokemon == "Charmander" || pokemon == "Squirtle"
      print "> "
      pokemon = gets.chomp
    end
    puts "You selected #{pokemon.upcase}. Great choice!
Give your pokemon a name?"
    print "> "
    pokemon_name = gets.chomp 
    p pokemon_name = pokemon if pokemon_name.empty? 
    puts "#{name.upcase}, raise your young #{pokemon_name.upcase} by making it fight!
When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"
    
    # Then create a Player with that information and store it in @player
    p Player.New(name, pokemon, pokemon_name)
    
    # Suggested game flow
    action = menu
    until action == "Exit"
      case action
      when "Train"
        train
        action = menu
      when "Leader"
        challenge_leader
        action = menu
      when "Stats"
        show_stats
        action = menu
      end
    end

    goodbye
  end

  def train
    # Complete this
  end

  def challenge_leader
    # Complete this
  end

  def show_stats
    # Complete this
  end

  def goodbye
    # Complete this
  end

  def menu
    # Complete this
  end
end

game = Game.new
game.start
