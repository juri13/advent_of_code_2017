require 'minitest/autorun'

def solution(banks)
  max_bank_position = 0
  result = 0
  states = {}
  n = banks.size

  loop do
    current_state_key = ''
    banks.each_with_index do |current_bank, i|
      current_state_key << current_bank.to_s
      if banks[max_bank_position] < current_bank
        max_bank_position = i
      end
    end

    if !states[current_state_key].nil?
      return result - states[current_state_key]
    end

    states[current_state_key] = result
    result += 1

    redistribute = banks[max_bank_position]
    banks[max_bank_position] = 0

    redistribute.times do |i|
      position = (max_bank_position + i + 1) % n
      banks[position] += 1
    end
  end

  0
end

class SolutionTest < ::MiniTest::Test
  def test_example_input
    assert_equal 4, solution([0, 2, 7, 0])
  end

  def test_solution
    assert_equal 1695, solution([0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11])
  end
end