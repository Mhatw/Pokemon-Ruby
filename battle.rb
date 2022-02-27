require_relative "pokedex/pokemons.rb"
class Battle
  # (complete parameters)
  def initialize(player, bot)
    # Complete this
    @player = player
    @bot = bot
    winner = start
  end

  def start
    # Prepare the Battle (print messages and prepare pokemons)
    prepare_for_battle
    fight
    # Until one pokemon faints
    # --Print Battle Status
    # --Both players select their moves

    # --Calculate which go first and which second

    # --First attack second
    # --If second is fainted, print fainted message
    # --If second not fainted, second attack first
    # --If first is fainted, print fainted message

    # Check which player won and print messages
    # If the winner is the Player increase pokemon stats
  end
  
  def fight
    #falta esto
   fight_puts

   until @player_hp_saved < 1 || @bot_hp_saved < 1
     @train_action = ""
     until @train_action == @player.pokemon_name.moves[0] || @train_action == @player.pokemon_name.moves[1]
       print "> "
       @train_action = gets.chomp
       @train_action_bot = @bot.pokemon_name.moves[rand(0..1)]
       prompt_algo = attack

       p @bot_hp_saved -= 11000 #por mientras pa que le peguen

     end
     
    end
    @player.pokemon_name.level += 10  ###por mientra para que suba de lvl
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
  p @train_action    ############################################################
  p @train_action_bot #############################################################
  round_winner = priority_attack(@train_action, @train_action_bot)
  stats_p = @player.pokemon_name ################### Refactorizar var de instancias
  stats_b = @bot.pokemon_name ###################Refactorizar var de instancias
  missed = rand(100) > @moves[round_winner[0]][:accuracy] ? true : false
  # -- Critical Hit check
  p critical_hit = rand(16) < 1 ? true : false

  # -- Calculate base damage #### hacerla metodo
  p empty_type_special = Pokedex::SPECIAL_MOVE_TYPE & Pokedex::POKEMONS[round_winner[1].pokemon_name.pokemon][:type]
  p empty_type_special = empty_type_special.empty? # give True if is empty
  p offensive_stat = empty_type_special == false ? round_winner[1].pokemon_name.special_attack : round_winner[1].pokemon_name.p_attack
  p move_power = @moves[round_winner[0]][:power]
  p target_defensive_stat = empty_type_special == false ? round_winner[2].pokemon_name.special_defense : round_winner[2].pokemon_name.defense
  p level = round_winner[1].pokemon_name.level
  p base_damage = (((2 * level / 5.0 + 2).floor * offensive_stat * move_power / target_defensive_stat).floor / 50.0).floor + 2
#################################################################################
######################## hasta aca llegamos #####################################
  
  # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
  # -- Effectiveness check
  # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
  # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
  # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
  # ---- "It doesn't affect [target name]!" when effectivenes is 0
  # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
  # Else, print "But it MISSED!"
end

def priority_attack(train_action, train_action_bot) 
  @moves =  Pokedex::MOVES

  stats_p = @player.pokemon_name
  stats_b = @bot.pokemon_name
  arr = []
  if @moves[train_action][:priority] != @moves[train_action_bot][:priority]
    if @moves[train_action][:priority] > @moves[train_action_bot][:priority]
      arr = [train_action, @player, @bot]
    else
      arr = [train_action_bot, @bot, @player]
    end
  elsif stats_p.speed != stats_b.speed
    if stats_p.speed > stats_b.speed
      arr = [train_action, @player, @bot]
    else
      arr = [train_action_bot, @bot, @player]
    end
  else 
    arr = [[train_action, @player, @bot], [train_action_bot, @bot, @player]].sample
  end
end

def prepare_for_battle
  # Complete this
  @player_hp_saved = @player.pokemon_name.hp
  @bot_hp_saved = @bot.pokemon_name.hp
end

end
