# require neccesary files
require_relative "pokedex/pokemons.rb"
class Pokemon
  attr_reader :pokemon_name, :pokemon, :level, :type, :hp, :p_attack, :defense, :moves
  attr_reader :special_attack, :special_defense, :speed, :experience_points, :stat_individual_values, :stat_effort
  attr_writer :level, :hp
  # include neccesary modules

  # (complete parameters)
  def initialize (pokemon_name, pokemon, level)
    # Retrieve pokemon info from Pokedex and set instance variables
    pokedex =  Pokedex::POKEMONS[pokemon]
    @pokemon_name = pokemon_name
    @pokemon = pokemon
    @level = level
    @type = pokedex[:type].join(", ")

    @stat_individual_values = { hp: rand(1..30), attack: rand(1..30), defense: rand(1..30), special_attack: rand(1..30), special_defense: rand(1..30), speed: rand(1..30) }
    @stat_effort = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @hp = ((2 * pokedex[:base_stats][:hp] + @stat_individual_values[:hp] + @stat_effort[:hp]) * @level / 100 + @level + 10).floor
    @p_attack = calculate_stats(pokedex[:base_stats][:attack], @stat_individual_values[:attack], @stat_effort[:attack], @level)     
    @defense = calculate_stats(pokedex[:base_stats][:defense], @stat_individual_values[:defense], @stat_effort[:defense], @level)  
    @special_attack = calculate_stats(pokedex[:base_stats][:special_attack], @stat_individual_values[:special_attack], @stat_effort[:special_attack], @level)  
    @special_defense = calculate_stats(pokedex[:base_stats][:special_defense], @stat_individual_values[:special_defense], @stat_effort[:special_defense], @level)  
    @speed = calculate_stats(pokedex[:base_stats][:speed], @stat_individual_values[:speed], @stat_effort[:speed], @level)  
    @experience_points = 0
    @moves = pokedex[:moves]
    # Calculate Individual Values and store them in instance variable
    # Create instance variable with effort values. All set to 0
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
  end

  def calculate_stats(base_stat, stat_individual_values, stat_effort, level)
    ((2 * base_stat + stat_individual_values + stat_effort) * level / 100 + 5).floor
  end

  def gain_experience
    # (base_experience * level / 7.0).floor

  end
  
  def prepare_for_battle
    # Complete this
    @player_hp_saved = @player.pokemon_name.hp
    @bot_hp_saved = @bot.pokemon_name.hp

  end

  def receive_damage
    # Complete this
  end

  def set_current_move
    # Complete this
  end

  def fainted?
    # Complete this
  end

  def attack(target)
    # Print attack message 'Tortuguita used MOVE!'
    # Accuracy check
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

  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"

    # If the new experience point are enough to level up, do it and print
    # message "#[pokemon name] reached level [level]!" # -- Re-calculate the stat
  end

  # private methods:
  # Create here auxiliary methods
end
