require_relative 'spec_helper'
# require_relative '../app'

RSpec.describe 'App' do
  it 'returns the expected output' do
    output = `ruby app.rb < sample-input.txt` # Run your shell script
    expect(output).to eq('Expected output')
  end
end