# require neccesary files
require_relative "player.rb"
require_relative "get_input"
require_relative "pokemon.rb"
require_relative "pokedex/pokemons.rb"
require_relative "pokedex/moves.rb"
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
    puts "#{@player.name} challenge Random Person for training
Random Person has a #{@bot.pokemon_name.pokemon_name} level #{@bot.pokemon_name.level}
What do you want to do now?\n
1. Fight        2. Leave "
    train_action = ""
    until train_action == "Fight" || train_action == "Leave"
      print "> "
      train_action = gets.chomp
    end
    if train_action == "Fight"
      # p prepare_for_battle  #######################################
      fight
    end

# Random Person has a Onix level 4
# What do you want to do now?"

  end

  def challenge_leader
    # Complete this
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

  def fight
     #falta esto
    fight_puts
    @player_hp_saved = @player.pokemon_name.hp ###recordar borrar
    @bot_hp_saved = @bot.pokemon_name.hp 
    p @player.pokemon_name.hp
    until @player_hp_saved < 0 || @bot_hp_saved < 0
      @train_action = ""
      until @train_action == @player.pokemon_name.moves[0] || @train_action == @player.pokemon_name.moves[1]
        print "> "
        @train_action = gets.chomp
        @train_action_bot = @bot.pokemon_name.moves[rand(0..1)]
        attack ####################
        p @player_hp_saved -= 4 #por mientras pa que le peguen

      end
      @player.pokemon_name.level = 10  ###por mientra para que suba de lvl

    end
    p @player_hp_saved    # para saber si sale con menos de 0 de vida de la pelea
    # llamar a los metodos de pokemon 
    p @player_hp_saved = @player.pokemon_name.hp # para regenerar la vida al final no es necesario per es pa mirar

    # fight_puts if #mayor
    #actualizar la vida 
    #ataque  = ""
  end
  
  def fight_puts
    puts "Random Person sent out #{@bot.pokemon_name.pokemon_name.upcase}!
#{@player.name} sent out #{@player.pokemon_name.pokemon_name.upcase}!
-------------------Battle Start!-------------------
  
#{@player.name}'s #{@player.pokemon_name.pokemon_name} - Level #{@player.pokemon_name.level}
HP: #{@player.pokemon_name.hp}
Random Person's #{@bot.pokemon_name.pokemon_name} - Level #{@bot.pokemon_name.level}
HP: #{@bot.pokemon_name.hp}
  
#{@player.name}, select your move:
  
1. #{@player.pokemon_name.moves[0]}      2. #{@player.pokemon_name.moves[1]}  "

  end

  def attack
    # Print attack message 'Tortuguita used MOVE!'
    puts "--------------------------------------------------
#{@player.pokemon_name.pokemon_name} used #{@train_action.upcase}!"
    # Accuracy check
    p @train_action
    p @train_action_bot
    p priority_attack(@train_action, @train_action_bot)
    
      ### player ataca first
      ## bot ataca first  
    # If the movement is not missed
    # -- Calculate base damage
    # -- Critical Hit check
    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
    # -- Effectiveness check
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    # Else, print "But it MISSED!"
  end

  def priority_attack(train_action, train_action_bot) ######por mientras
    moves =  Pokedex::MOVES
    stats_p = @player.pokemon_name
    stats_b = @bot.pokemon_name

    if moves[train_action][:priority] != moves[train_action_bot][:priority]
      if moves[train_action][:priority] > moves[train_action_bot][:priority]
        puts "priority"
        train_action
      else
        puts "priority bot"
        train_action_bot
      end
    elsif stats_p.speed != stats_b.speed
      if stats_p.speed > stats_b.speed
        puts "speed"
        puts stats_p.speed 
        puts stats_b.speed 
        train_action
      else
        puts "speed bot"
        puts stats_p.speed 
        puts stats_b.speed 
        train_action_bot
      end
    else 
      puts "a la dios"
      [train_action, train_action_bot].sample
    end
  end
end


game = Game.new
game.start
