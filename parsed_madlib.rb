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

