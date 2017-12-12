require 'minitest/autorun'

def solution(list, lengths)
  n = list.size
  current_position = 0
  skip_size = 0

  lengths.each do |length|
    next if length > n

    sublist = list[current_position...(current_position + length)]
    if (current_position + length) > n
      sublist |= list[0...((current_position + length) - n)]
    end

    reversed_sublist = sublist.reverse

    if (current_position + length) > n
      list[current_position...n] = reversed_sublist[0...(n - current_position)]
      list[0...(current_position + length - n)] = reversed_sublist[(n - current_position)...length]
    else
      list[current_position...(current_position + length)] = reversed_sublist[0...length]
    end

    current_position = (current_position + length + skip_size) % n
    skip_size += 1
  end

  list[0] * list[1]
end

class SolutionTest < ::MiniTest::Test
  def test_example_input
    assert_equal 12, solution((0..4).to_a, [3, 4, 1, 5])
  end

  def test_solution
    assert_equal 826, solution((0..255).to_a, [120, 93, 0, 90, 5, 80, 129, 74, 1, 165, 204, 255, 254, 2, 50, 113])
  end
end