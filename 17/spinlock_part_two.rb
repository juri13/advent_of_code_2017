require 'minitest/autorun'

def solution(step)
  buffer_size = 1
  position = 0
  result = 0

  1.upto(50000000) do |i|
    position = ((position + step) % buffer_size) + 1

    if position == 1
      result = i
    end

    buffer_size += 1
  end

  result
end

class SolutionTest < ::MiniTest::Test
  def test_solution
    assert_equal 1930815, solution(304)
  end
end