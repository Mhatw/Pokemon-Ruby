require_relative "pokedex/pokemons"
class Battle
  # (complete parameters)
  def initialize(player, bot, es_brock)
    # Complete this
    @player = player
    @bot = bot
    @es_brock = es_brock
    winner = start
  end

  def start
    # Prepare the Battle (print messages and prepare pokemons)
    prepare_for_battle
    fight
  end

  def fight
    puts "\n#{@bot.name} sent out #{@bot.pokemon_name.pokemon_name.upcase}!
#{@player.name} sent out #{@player.pokemon_name.pokemon_name.upcase}!
      -------------------Battle Start!-------------------"
    until @player_hp_saved < 1 || @bot_hp_saved < 1 # acordar sacar el loop
      fight_status(@player_hp_saved, @bot_hp_saved)
      @train_action = ""
      until @train_action == @player.pokemon_name.moves[0] || @train_action == @player.pokemon_name.moves[1]
        print "\n1. #{@player.pokemon_name.moves[0]}      2. #{@player.pokemon_name.moves[1]} \n> "
        @train_action = gets.chomp
      end
      # --Bot player select move
      @train_action_bot = @bot.pokemon_name.moves[rand(0..1)]
      # Print attack message 'Tortuguita used MOVE!'
      # Accuracy check
      @round_arr = priority_attack(@train_action, @train_action_bot)
      puts "\n--------------------------------------------------
#{@round_arr[2].pokemon_name.pokemon_name} used #{@round_arr[0].upcase}!"
      life_loose_w = attack(0, 2, 3)
      # 3
      receive_damage(life_loose_w, 2)
      next unless are_you_live == true

      puts "--------------------------------------------------
      #{@round_arr[3].pokemon_name.pokemon_name} used #{@round_arr[1].upcase}!"
      life_loose_l = attack(1, 3, 2)
      receive_damage(life_loose_l, 3)
      puts "--------------------------------------------------"
      are_you_live
    end
    nil
  end

  def are_you_live
    if !@player_hp_saved.positive?
      puts "--------------------------------------------------"
      (puts "#{@player.pokemon_name.pokemon_name} FAINTED!\n#{'-' * 50}\n#{@bot.pokemon_name.pokemon_name} WINS!")
      puts "-------------------Battle Ended!-------------------"
      @fight_winner = @bot
      return false
    elsif !@bot_hp_saved.positive?
      puts "--------------------------------------------------"
      (puts "#{@bot.pokemon_name.pokemon_name} FAINTED!\n#{'-' * 50}\n#{@player.pokemon_name.pokemon_name} WINS!")
      @player.pokemon_name.gain_experience(@bot.pokemon_name.pokemon, @bot.pokemon_name.level)
      puts "-------------------Battle Ended!-------------------"
      # aumentar
      @player.pokemon_name.effort(@round_arr[3].pokemon_name.pokemon)
      if @es_brock == true
        puts "Congratulation! You have won the game!\nYou can continue training your Pokemon if you want"
      end
      @fight_winner = @player
      return false
    end
    true
  end

  def receive_damage(life_loose, iterador)
    # Complete this
    @round_arr[iterador] == @player ? @bot_hp_saved -= life_loose : @player_hp_saved -= life_loose
  end

  def fight_status(player, bot)
    puts "#{@player.name}'s #{@player.pokemon_name.pokemon_name} - Level #{@player.pokemon_name.level}
HP: #{player}
#{@bot.name}'s #{@bot.pokemon_name.pokemon_name} - Level #{@bot.pokemon_name.level}
HP: #{bot}

#{@player.name}, select your move:"
  end

  def attack(ataque, p_win, p_loose)
    # -- Missed?
    missed = missed(ataque)
    # -- Critical Hit check
    critical_hit = critical_method
    # -- Calculate base damage
    base_damage = bdmg_method(p_win, p_loose)
    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
    base_damage *= 1.5 if critical_hit == true
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    damage = (base_damage * effectiveness(ataque, p_loose))
    damage = damage.floor
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    missed == false ? (puts "And it hit #{@round_arr[3].pokemon_name.pokemon_name} with #{damage} damage") : (puts "But it MISSED!")
    # Else, print "But it MISSED!"
    missed == false ? damage : 0
  end

  def missed(i)
    rand(100) > @moves[@round_arr[i]][:accuracy]
  end

  # -- Effectiveness cseheck
  def effectiveness(ataque, perdedor)
    p_receive = Pokedex::POKEMONS[@round_arr[perdedor].pokemon_name.pokemon][:type]
    c = Pokedex::TYPE_MULTIPLIER.select do |x|
      x[:user] == Pokedex::MOVES[@round_arr[ataque]][:type] && x[:target] == p_receive[0]
    end
    a = Pokedex::TYPE_MULTIPLIER.select do |x|
      x[:user] == Pokedex::MOVES[@round_arr[ataque]][:type] && x[:target] == p_receive[1]
    end
    # { user: :normal, target: :rock, multiplier: 0.5 }
    c = c.nil? || c.empty? ? 1 : c[0][:multiplier]
    a = a.nil? || a.empty? ? 1 : a[0][:multiplier]
    efectividad = c * a
    if efectividad <= 0.5 && efectividad != 0
      puts "It's not very effective..."
    elsif efectividad >= 1.5
      puts "It's super effective!"
    elsif efectividad == 0
      puts "It doesn't affect #{perdedor.pokemon_name.pokemon_name}!"
    end
    efectividad # give a multiplier
  end

  # -- Calculate base damage 2
  # hacer funcion off y deff
  def bdmg_method(p_win, p_loose)
    empty_type_special = [Pokedex::SPECIAL_MOVE_TYPE & Pokedex::POKEMONS[@round_arr[p_win].pokemon_name.pokemon][:type]].empty?
    offensive_stat = empty_type_special == false ? @round_arr[p_win].pokemon_name.special_attack : @round_arr[p_win].pokemon_name.p_attack
    move_power = @moves[@round_arr[p_win - 2]][:power]
    target_defensive_stat = empty_type_special == false ? @round_arr[p_loose].pokemon_name.special_defense : @round_arr[p_loose].pokemon_name.defense
    level = @round_arr[p_win].pokemon_name.level
    ((((2 * level / 5.0) + 2).floor * offensive_stat * move_power / target_defensive_stat).floor / 50.0).floor + 2
  end

  def critical_method
    if rand(16) < 1
      puts "It was CRITICAL hit!"
      return true
    end
    false
  end

  def priority_attack(train_action, train_action_bot)
    @moves = Pokedex::MOVES
    # [mov ganador , mov perdedor, ganador, perdedor]
    arr = []
    arr = if @moves[train_action][:priority] != @moves[train_action_bot][:priority]
            if @moves[train_action][:priority] > @moves[train_action_bot][:priority]
              [train_action, train_action_bot, @player, @bot]
            else
              [train_action_bot, train_action, @bot, @player]
            end
          elsif @player.pokemon_name.speed != @bot.pokemon_name.speed
            if @player.pokemon_name.speed > @bot.pokemon_name.speed
              [train_action, train_action_bot, @player, @bot]
            else
              [train_action_bot, train_action, @bot, @player]
            end
          else
            [[train_action, train_action_bot, @player, @bot], [train_action_bot, train_action, @bot, @player]].sample
          end
  end

  def prepare_for_battle
    # Complete this
    @player_hp_saved = @player.pokemon_name.hp
    @bot_hp_saved = @bot.pokemon_name.hp
  end
end
# Hola
