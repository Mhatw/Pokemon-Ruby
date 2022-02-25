module GetInput
  # attr_reader :input

  def get_input
    input = ""
    while input.empty?
      print "> "
      input = gets.chomp
    end
    input
  end
  
  # def print_options(options)
  #   options.each.with_index { |option, index| puts "#{index+1}. #{option.capitalize}" }
  # end
  
end