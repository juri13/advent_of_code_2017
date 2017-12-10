require 'minitest/autorun'

def solution(square)
  k = ((Math.sqrt(square) - 1) / 2.0).ceil
  t = 2 * k + 1
  m = t ** 2
  t -= 1

  3.times do |i|
    m -= t unless i == 0
    if square >= m - t
      if i == 2
        return t - (m - square)
      else
        return (m - square)
      end
    end
  end

  k - (m - square - t) + k
end

class SolutionTest < ::MiniTest::Test
  def test_example_input_1
    assert_equal 0, solution(1)
  end

  def test_example_input_2
    assert_equal 3, solution(12)
  end

  def test_example_input_3
    assert_equal 2, solution(23)
  end

  def test_example_input_4
    assert_equal 31, solution(1024)
  end

  def test_solution
    assert_equal 326, solution(361527)
  end
end