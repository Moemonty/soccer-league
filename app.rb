def main
  # Get Filename if passed as argument
  if ARGV[0]
    filename = ARGV[0]
    array_of_lines = []
    line_count = 0

    File.open(filename, 'r') do |file|
      file.each_line do |line|
        array_of_lines << line
        line_count += 1
      end
    end

    read_lines_global(array_of_lines, line_count)
  else
    array_of_lines = []
    line_count = 0

    if $stdin
      ARGF.each_line do |line|
        array_of_lines << line
        line_count += 1
      end

      read_lines_global(array_of_lines, line_count)
    end
  end
end

def read_lines_global(matches, line_count)
  team_obj = {}
  line_count = line_count
  match_day = 0


  curr_line = 1
  # We have line count
  # depending on the size of the input
  # we can say that we can there will be half that many lines of output
  # and we know there are always two teams playing, we divide by that
  # so Lines of input / Half, one outcome per line of input / and divided again by 2, because two teams
  # so 24 lines of input would results in (12 / 2 / 2) == 3
  match_day_end = (line_count / 2) / 2

  matches.each do |match|
    match_info = parse_match_info(match)

    if match_info.nil? || !match_info
      next
    end

    result = determine_winner_and_score(match_info[:team_1_score], match_info[:team_2_score])

    if !team_obj.has_key?(match_info[:team_1_name])
      team_obj[match_info[:team_1_name]] = 0
    end

    if !team_obj.has_key?(match_info[:team_2_name])
      team_obj[match_info[:team_2_name]] = 0
    end

    if result[:winner] == 1
      team_obj[match_info[:team_1_name]] += result[:score]
      team_obj[match_info[:team_2_name]] += 0
    end
    if result[:winner] == 2
      team_obj[match_info[:team_2_name]] += result[:score]
      team_obj[match_info[:team_1_name]] += 0
    end

    if result[:winner] == 0
      team_obj[match_info[:team_1_name]] += result[:score]
      team_obj[match_info[:team_2_name]] += result[:score]
    end

    # Determined when to print from input (current line / matches / teams per match) 12 / 2 / 2 == 3
    if curr_line % match_day_end == 0
      match_day += 1
      puts "Match Day #{match_day}"
      parse_and_print_matchday(team_obj)
      puts "\n"
    end

    curr_line += 1
  end
end

def parse_match_info(match)
  match_details = match.split(',')
  team_1 = match_details[0]
  team_2 = match_details[1]
  team_1_name = team_1.gsub(/\d/, '').strip
  team_1_score = team_1[/\d+/]
  team_2_name = team_2.gsub(/\d/, '').strip
  team_2_score = team_2[/\d+/]

  # Asset conditions here
  return false if match_details.nil? || team_1_score.nil? || team_2_score.nil?

  {
    team_1_name: team_1_name,
    team_1_score: team_1_score,
    team_2_name: team_2_name,
    team_2_score: team_2_score
  }
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

  result.each do |r|
    puts r
  end
end

main