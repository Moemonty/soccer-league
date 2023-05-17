## Soccer League

## Ruby Version
Built using Ruby 3.2.2

## Dependencies:

Install Rspec
`gem install rspec`
---

Run Rspec Init
`rspec --init`

Install `Ruby 3.2.2`
Can install with rbenv
`https://github.com/rbenv/rbenv`

---


### To run:

Run via terminal stdin:

`ruby app.rb < sample-input.txt`

Run via an argument:

`ruby app.rb sample-input.txt`


### To run test:
Go to root directory and below in terminal/iterm2, etc.

`rspec spec/app_spec.rb`



### Design Document, thoughts and requirements:

My thoughts for this command line Ruby application were as follows.

I would take input as stated:
1. Via stdin redirected or piped
2. As a file path if the first argument was provided

After setting up the input mechanisms, I knew I had to parse out each line of the input, as each of those were a match.

The tricky part was figuring out when a matchday ended.

---

The way I figured a matchday would end, was as such. 

Given all the input lines were consumed, once I had a count of the
input lines, I knew that those were the number of matches.

So given I had 12 lines/matches, let's say, I knew that 6 teams were playing against each other.

And if teams could only play once a day, that math would make it so that each match day was 3 matches.

Using that count of matches, based on the total input lines, I was able to first get a count of all inputs, and then
continue iterating through all input lines and then parse out the information I needed.

Using a running count and a modulo as computed above, I was able to log matchday stats when needed. 

For pointing, as indicated in the prompt, I did the following:

A win for a team would net the winning team 3 points.
A tie would net both teams 1 point.
And a loss for a team would net 0 points.
I implemented that logic.

---

I think that does it!

Thanks for the opportunity!

**Moises Montenegro**