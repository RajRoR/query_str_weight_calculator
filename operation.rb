require_relative 'page_guage'

str_ip = "P Ford Car Review

          P Review Car

          P Review Ford

          P Toyota Car

          P Honda Car

          P Car

          Q Ford

          Q Car

          Q Review

          Q Ford Review

          Q Ford Car

          Q cooking French"

max_ix = 8

pg =  PageGuage.new(str_ip, max_ix)

puts pg.result
