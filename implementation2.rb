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