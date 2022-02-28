module GetInput

  def get_input
    input = ""
    while input.empty?
      print "> "
      input = gets.chomp
    end
    input
  end
end