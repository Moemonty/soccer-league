RSpec.describe 'App' do
  before(:each) do
    @expected_output = "Match Day 1\nCapitola Seahorses, 3 pts\nFelton Lumberjacks, 3 pts\nSan Jose Earthquakes, 1 pts\n\nMatch Day 2\nCapitola Seahorses, 4 pts\nAptos FC, 3 pts\nFelton Lumberjacks, 3 pts\n\nMatch Day 3\nAptos FC, 6 pts\nFelton Lumberjacks, 6 pts\nMonterey United, 6 pts\n\nMatch Day 4\nAptos FC, 9 pts\nFelton Lumberjacks, 7 pts\nMonterey United, 6 pts\n\n"
  end

  it 'returns the expected output via a stdin redirect' do
    output = `ruby app.rb < sample-input.txt`

    expect(output).to eq(@expected_output)
  end

  it 'returns the expected output via an argument' do
    output = `ruby app.rb sample-input.txt`
    expect(output).to eq(@expected_output)
  end

  it 'Aptos FC takes a loss' do
    output = `ruby app.rb < input-missing-scores.txt`

    expect(@expected_output).to include('Aptos FC, 9 pts')
    expect(output).not_to include('Aptos FC, 9 pts')
    expect(output).to include('Aptos FC, 6 pts')
  end

  it 'Aptos FC takes a tie' do
    output = `ruby app.rb < aptos-ties.txt`
    expect(@expected_output).to include('Aptos FC, 9 pts')
    expect(output).not_to include('Aptos FC, 9 pts')
    expect(output).to include('Aptos FC, 7 pts')
  end

  it 'no file is passed in' do
    output = `ruby app.rb`
    expect(@expected_output).to include('Aptos FC, 9 pts')
    expect(output).not_to include('Aptos FC, 9 pts')
    expect(output).to include('Aptos FC, 7 pts')
  end
end