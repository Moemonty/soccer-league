def parse
  # Get Filename if passed as argument
  if ARGV[0]
    filename = ARGV[0]
    read_from_argument(filename)
  else
    if $stdin
      read_from_stdin
    end
  end



  # input = $stdin.gets.chomp



  # Stdin Pipe:
  # $ echo "Test" | ruby app.rb

  # Stdin Redirect
  # ruby app.rb < sample-input.txt

  # if input.nil? || input.empty?
  #   read_from_file
  # else
  #   puts "The input was #{input}"
  # end
end

def read_from_argument(filename)
  File.open(filename, 'r') do |file|
    file.each_line do |line|
      puts line
    end
  end
end

def read_from_stdin
  $stdin.each_line do |line|
    puts line.chomp
  end
end

def read_from_file
  puts "Reading from file"
end

parse