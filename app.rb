def parse
  # Get Filename if passed as argument
  if ARGV[0]
    filename = ARGV[0]
    read_from_argument(filename)

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

  File.open(filename, 'r') do |file|
    file.each_line do |match|
      # For each line, split by comman
      match_details = match.split(',')
      puts match_details
      team_1 = match_details[0]
      team_2 = match_details[1]

      team_1_name = team_1.gsub(/\d/, '').strip
      team_1_score = team_1[/\d+/]

      puts team_1_name
      puts team_1_score

      team_2_name = team_2.gsub(/\d/, '').strip
      team_2_score = team_2[/\d+/]


      # Calculate which team one, tied or lost
      result = determine_winner_and_score(team_1_score, team_2_score)

      puts result

      # IF ONE TEAM ALREADY EXISTS, THEY ALL EXIST, so report team object and clear out that day's info
      if team_obj[team_1_name]
        puts "The Matchday is over, not start iterating through the object and return the top team"

        puts team_obj
      end

      # initialize if don't exist || IF THEY DO Exist, its another match day
      if !team_obj[team_1_name] && !team_obj[team_2_name]
        if result[:winner] == 1
          team_obj[team_1_name] = result[:score]
          team_obj[team_2_name] = 0
        end
        if result[:winner] == 2
          team_obj[team_2_name] = result[:score]
          team_obj[team_1_name] = 0
        end
        if result[:winner] == "tied"
          team_obj[team_1_name] = result[:score]
          team_obj[team_2_name] = result[:score]
        end
      end
      # if !team_obj[team_1_name]
      #   if result[:winner] == 1
      #     team_obj[team_1_name] = result[:score]
      #     team_obj[team_2_name] = 0
      #   end
      #
      #   if result[:winner] == "tied"
      #     team_obj[team_1_name] = result[:score]
      #   end
      # end
      #
      # if !team_obj[team_2_name]
      #   if result[:winner] == 2
      #     team_obj[team_2_name] = result[:score]
      #   end
      #
      #   if result[:winner] == "tied"
      #     team_obj[team_2_name] = result[:score]
      #   end
      # end


      puts team_obj
      puts team_obj
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

  if team2_score > team2_score
    return { winner: 2, score: 3}
  end

  if team1_score == team2_score
    return { winner: 'tied', score: 1}
  end
end

def read_from_file
  puts "Reading from file"
end

parse