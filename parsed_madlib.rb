class Replacement
  def self.parse?(token, replacements)
    if token[0..1] == "((" and replacements.include?( token[2..-1] )
      new(token[2..-1], replacements)
    else
      false
    end
  end

  def initialize( name, replacements )
    @name = name
    @replacements = replacements
  end

  def to_s
    @replacements[@name]
  end
end

class Question
  def self.parse?( prompt, replacements )
    if prompt.sub!(/^\(\(/, "")
      prompt, name = prompt.split(":").reverse
      replacements[name] = nil unless name.nil?

      new(prompt, name, replacements)
    else
      false
    end
  end

  def intialize( prompt, name, replacements )
    @prompt = prompt
    @name = name
    @replacements = replacements
  end

  def to_s
    print "Enter #{@prompt}: "
    answer = $stdin.gets.to_s.strip

    @replacements[@name] = answer unless @name.nil?

    answer
  end
end

class String
  def self.parse(token, replacements)
    new(token)
  end
end

unless ARGV.size == 1 and test(?e, ARGV[0])
  puts "Usage: #{File.basename($PROGRAM_NAME)} MADLIB_FILE"
  exit
end
madlib = <<MADLIB

MADLIB

tokens = madlib.split(/(\(\([^)]+)\)\)/).map do |token|
  token[0..1] == "((" ? token.gsub(/\s+/, " ") : token
end

answers = Hash.new
story = tokens.map do |token|
  [Replacement, Question, String].inject(false) do |element, kind|
  element = kind.parse?(token, answers) and break element
  end
end

puts story.join
