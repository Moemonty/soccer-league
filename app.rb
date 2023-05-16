def parse
  # Get Filename if passed as argument
  if ARGV[0]
    filename = ARGV[0]
    result = read_from_argument(filename)
    puts result
  else
    if $stdin
      read_from_stdin
    end
  end
end

# If a team's name repeats, we know that a new matchday has started
def get_match_info
end

def read_from_argument(filename)
  team_obj = {}
  match_day_count = 0

  File.open(filename, 'r') do |file|
    file.each_line do |match|
      # For each line, split by comman
      match_details = match.split(',')

      team_1 = match_details[0]
      team_2 = match_details[1]

      team_1_name = team_1.gsub(/\d/, '').strip
      team_1_score = team_1[/\d+/]

      team_2_name = team_2.gsub(/\d/, '').strip
      team_2_score = team_2[/\d+/]


      # IF ONE TEAM ALREADY EXISTS, THEY ALL EXIST, so report team object and clear out that day's info
      # if team_obj.has_key?(team_1_name)
      #   match_day_count += 1
      #   puts "Matchday #{match_day_count}"
      #   results = parse_and_print_matchday(team_obj)
      #   results.each do |result|
      #     puts result
      #   end
      #
      #   #clear out team_obj
      #   team_obj = {}
      #   next
      # end

      result = determine_winner_and_score(team_1_score, team_2_score)

      if !team_obj.has_key?(team_1_name)
        team_obj[team_1_name] = 0
      end

      if !team_obj.has_key?(team_2_name)
        team_obj[team_2_name] = 0
      end

      if result[:winner] == 1
        team_obj[team_1_name] += result[:score]
        team_obj[team_2_name] += 0
      end
      if result[:winner] == 2
        team_obj[team_2_name] += result[:score]
        team_obj[team_1_name] += 0
      end
      if result[:winner] == 0
        team_obj[team_1_name] += result[:score]
        team_obj[team_2_name] += result[:score]
      end

      puts team_obj
      team_obj
    end
  end
end

def read_from_stdin
  $stdin.each_line do |line|
    puts line.chomp
  end
end

def determine_winner_and_score(team1_score, team2_score)
  if team1_score > team2_score
    return { winner: 1, score: 3}
  end

  if team2_score > team1_score
    return { winner: 2, score: 3}
  end

  if team1_score == team2_score
    return { winner: 0, score: 1}
  end
end

def parse_and_print_matchday(team_obj)
  sorted_hash = team_obj.sort do |(key1, value1), (key2, value2)|
    [value2, key1.downcase] <=> [value1, key2.downcase]
  end
  # https://ruby-doc.org/core-2.2.2/Hash.html -- Hashes retain order

  # Take the first three items
  top_teams = sorted_hash.to_a.take(3).to_h

  result = []
  top_teams.each do |key, val|
    result << "#{key}, #{val} pts"
  end

  result
end

def read_from_file
  puts "Reading from file"
end

parse