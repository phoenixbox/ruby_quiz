require 'erb'

class MadLibs

  def input
    print "Please enter an adjective :"
    @adjective = gets.chomp
    print "Please enter a body_part :"
    @body_part = gets.chomp
    print "Please enter a noun :"
    @noun = gets.chomp
    mad_libs
  end
  
  def mad_libs 
    sentence = ERB.new %q{I had a <%= @adjective %> sandwich for lunch today. It dripped all over my <%= @body_part %> and <%= @noun %>.}
    puts sentence.result(binding)
  end

end


MadLibs.new.input

