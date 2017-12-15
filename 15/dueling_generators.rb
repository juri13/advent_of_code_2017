require 'minitest/autorun'

def solution(generator_a_value, generator_b_value)
  matching = 0

  40_000_000.times do
    generator_a_value = next_value(generator_a_value, 16807)
    generator_a_bits = generator_a_value.to_s(2).chars.last(16).join

    generator_b_value = next_value(generator_b_value, 48271)
    generator_b_bits = generator_b_value.to_s(2).chars.last(16).join

    matching += 1 if generator_a_bits == generator_b_bits
  end

  matching
end

def next_value(current_value, factor)
  (current_value * factor) % 2147483647
end

class SolutionTest < ::MiniTest::Test
  def test_example_input
    assert_equal 588, solution(65, 8921)
  end

  def test_solution
    assert_equal 592, solution(277, 349)
  end
end