# require neccesary files
require_relative "pokedex/pokemons.rb"
class Pokemon
  attr_reader :pokemon_name, :pokemon, :type, :hp, :p_attack, :defense, :moves, :effort_points, :stat_effort_value
  attr_reader :special_attack, :special_defense, :speed, :experience_points, :stat_individual_values, :stat_effort
  attr_accessor :hp, :level
  # include neccesary modules

  # (complete parameters)
  def initialize(pokemon_name, pokemon, level)
    # Retrieve pokemon info from Pokedex and set instance variables
    @pokedex = Pokedex::POKEMONS[pokemon]
    @pokemon_name = pokemon_name
    @pokemon = pokemon
    @level = level
    @type = @pokedex[:type].join(", ")

    @stat_individual_values = { hp: rand(30), attack: rand(30), defense: rand(30), special_attack: rand(30), special_defense: rand(30), speed: rand(30) }
    @stat_effort = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @stat_effort_value = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @hp = calc_stats(:hp) + @level + 5
    @p_attack = calc_stats(:attack)
    @defense = calc_stats(:defense)
    @special_attack = calc_stats(:special_attack)
    @special_defense = calc_stats(:special_defense)
    @speed = calc_stats(:speed)
    @experience_points = 0
    @moves = @pokedex[:moves]
  end

  def calc_stats(key)
    ((2 * (@pokedex[:base_stats][key]) + (@stat_individual_values[key]) + (@stat_effort[key])) * @level / 100 + 5).floor
  end

  def gain_experience(pok, level)
    # (base_experience * level / 7.0).floor
    g_exp = (Pokedex::POKEMONS[pok][:base_exp] * level / 7.0).floor
    puts "#{@pokemon_name} gained #{g_exp} experience points"
    t_exp = @experience_points + g_exp
    case Pokedex::POKEMONS[@pokemon][:growth_rate]
    when :slow
      n_exp = ((5 * (@level + 1) ** 3) / 4.0).floor
    when :medium_slow
      n_exp = (6 / 5.0 * ((@level + 1)**3) - 15 * ((@level + 1)**2) + 100 * (@level + 1) - 140).floor
    when :medium_fast
      n_exp = ((@level + 1)**3).floor
    when :fast
      n_exp = ((4 * (@level + 1) ** 3) / 5.0).floor
    end
    if t_exp >= n_exp
      @experience_points += g_exp
      @level += 1
      puts "#{@pokemon_name} reached level #{@level}!"
      increase_stats
    else
      @experience_points += g_exp
    end

  end

  def effort (thepokemon)
    amount = Pokedex::POKEMONS[thepokemon][:effort_points][:amount]
    type = Pokedex::POKEMONS[thepokemon][:effort_points][:type]
    @stat_effort_value[type] += amount
    @stat_effort_value.each do |n, m|
          if n == type && m >= 4
            @stat_effort_value[type] = m - 4
            @stat_effort[type] += 1
          end
      end
  end

  def increase_stats
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"
    @hp = calc_stats(:hp) + @level + 5
    @p_attack = calc_stats(:attack)
    @defense = calc_stats(:defense)
    @special_attack = calc_stats(:special_attack)
    @special_defense = calc_stats(:special_defense)
    @speed = calc_stats(:speed)
  end
end
