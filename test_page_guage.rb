require 'minitest/autorun'
require_relative 'page_guage'

class TestPageGuage < MiniTest::Test
  def setup
    max_weight = 8
    @pg = PageGuage.new(_test_data_ip, max_weight)
  end

  def test_the_result
    assert_equal _expected_answer, @pg.result
  end

  private

  def _test_data_ip
    "P Ford Car Review\n\n              P Review Car\n\n              P Review Ford\n\n              P Toyota Car\n\n              P Honda Car\n\n              P Car\n\n              Q Ford\n\n              Q Car\n\n              Q Review\n\n              Q Ford Review\n\n              Q Ford Car\n\n              Q cooking French"
  end

  def _expected_answer
    "Q1:  P1 P3\nQ2:  P6 P5 P4 P2 P1\nQ3:  P3 P2 P1\nQ4:  P3 P1 P2\nQ5:  P1 P6 P3 P5 P4 P2\nQ6: \n"
  end
end
