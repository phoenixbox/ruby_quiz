$answers = Hash.new

def q_to_a(question)
 question.gsub!(/\s+/, " ")
 if $answers.include?( question )
    $answers[ question ]
 else
  key = if question.sub!(/^\s*(.+?)\s*:\s*/, "") then $1 else nil end

  print "Give me #{ question }: "
  answer = $stdin.gets.chomp

  $answers[key] = answer unless key.nil?

  answer
 end
end

unless ARGV.size == 1  and test(?e, ARGV[0])
  puts "Usage: #{File.basename($PROGRAM_NAME)} MADLIB_FILE"
  exit
end

madlib = "\n#{File.basename(ARGV.first, '.madlib').tr('_', ' ')}\n\n" +
          File.read(ARGV.first)

madlib.gsub!(/\(\(\s*(.+?)\s*\)\)/, "<%= q_to_a(' \\1' ) %>")

ERB.new(madlib).run