require 'minitest/autorun'

def solution(step)
  buffer = [0]

  1.upto(2017) do |i|
    buffer.rotate!(step + 1)
    buffer.insert(1, i)
  end

  buffer[2]
end

class SolutionTest < ::MiniTest::Test
  def test_example_input
    assert_equal 638, solution(3)
  end

  def test_solution
    assert_equal 1173, solution(304)
  end
end