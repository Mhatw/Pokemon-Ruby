# require neccesary files
require_relative "player.rb"
require_relative "get_input"
require_relative "pokemon.rb"
require_relative "pokedex/pokemons.rb"
require_relative "pokedex/moves.rb"
require_relative "battle.rb"
include GetInput

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

    # get name
    name = get_input

    puts "Right! So your name is #{name.upcase}!
Your very own POKEMON legend is about to unfold! A world of
dreams and adventures with POKEMON awaits! Let's go!
Here, #{name.upcase}! There are 3 POKEMON here! Haha!
When I was young, I was a serious POKEMON trainer.
In my old age, I have only 3 left, but you can have one! Choose!

1. Bulbasaur    2. Charmander   3. Squirtle "

    # get pokemon
    pokemon = ""
    until pokemon == "Bulbasaur" || pokemon == "Charmander" || pokemon == "Squirtle"
      print "> "
      pokemon = gets.chomp
    end
    
    puts "You selected #{pokemon.upcase}. Great choice!
Give your pokemon a name?"

    # get pokemon
    pokemon_name = get_input
    pokemon_name = pokemon if pokemon_name.empty?

    puts "#{name.upcase}, raise your young #{pokemon_name.upcase} by making it fight!
When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"

    # Then create a Player with that information and store it in @player
    @player = Player.new(name, pokemon, pokemon_name, 1)
    @player.pokemon_name.type
    # Suggested game flow
    menu
    action = get_input
    until action == "Exit"
      case action
      when "Train"
        train
        action = menu
      when "Leader"
        challenge_leader
        action = menu
      when "Stats"
        show_stats(@player)
        action = menu
      else
        action = get_input
        
      end
    end

    goodbye
  end

  def train
    # Complete this
    @bot = Bot.new(rand(@player.pokemon_name.level..@player.pokemon_name.level + 0))
    puts "\n#{@player.name} challenge Random Person for training
Random Person has a #{@bot.pokemon_name.pokemon_name} level #{@bot.pokemon_name.level}
What do you want to do now?\n
1. Fight        2. Leave "
    train_action = ""
    until train_action == "Fight" || train_action == "Leave"
      print "> "
      train_action = gets.chomp
    end
    if train_action == "Fight"
      # @player.pokemon_name.prepare_for_battle(@player, @bot)
      algo_saldra = Battle.new(@player, @bot, false) ###################
    end
    # Random Person has a Onix level 4
    # What do you want to do now?"
  end
  
  def challenge_leader
    # Complete this
    @brock = Brock.new
    puts "\n#{@player.name} challenge the Gym Leader Brock for a fight!
Brock has a Onix level 10
What do you want to do now?\n
1. Fight        2. Leave "
    train_action = ""
    until train_action == "Fight" || train_action == "Leave"
      print "> "
      train_action = gets.chomp
    end
    if train_action == "Fight"
      # @player.pokemon_name.prepare_for_battle(@player, @bot)
      Battle.new(@player, @brock, true) ###################
    end


  end

  def show_stats(player)
    stats = @player.pokemon_name
    puts "\n#{stats.pokemon_name}"
    puts "Kind: #{@player.pokemon}"
    puts "Level: #{stats.level}" #jalar el lvl
    puts "Type: #{stats.type}"
    puts "Stats:"
    puts "HP: #{stats.hp}"
    puts "Attack: #{stats.p_attack}"
    puts "Defense: #{stats.defense}"
    puts "Special Attack: #{stats.special_attack}"
    puts "Special Defense: #{stats.special_defense}"
    puts "Speed: #{stats.speed}"
    puts "Experience Points: #{stats.experience_points}"
  end

  def goodbye
    # Complete this
    puts "Thanks for playing Pokemon Ruby
This game was created with love by: [your names]"
  end

  def menu
    # Complete this
    puts "-----------------------Menu-----------------------
    
1. Stats        2. Train        3. Leader       4. Exit "
  end
  
end


game = Game.new
game.start
