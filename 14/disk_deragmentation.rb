require 'minitest/autorun'

def solution(input)
  result = 0

  128.times do |row|
    string = "#{input}-#{row}"
    hash = knot_hash(string)
    binary = hash.chars.collect{ |h| h.hex.to_s(2).rjust(4, '0') }.join
    result += binary.scan(/1/).count
  end

  result
end

def knot_hash(input)
  list = (0..255).to_a
  n = list.size

  lengths = input.chars.collect { |char| char.ord } + [17, 31, 73, 47, 23]

  current_position = 0
  skip_size = 0

  64.times do
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
  end

  dense_hash = []

  list.each_slice(16) do |sublist|
    dense_hash << sublist.reduce(:^)
  end

  dense_hash.collect{ |int| int.to_s(16).rjust(2, '0') }.join.force_encoding('UTF-8')
end

class SolutionTest < ::MiniTest::Test
  def test_example_input
    assert_equal 8108, solution('flqrgnkx')
  end

  def test_solution
    assert_equal 8074, solution('jzgqcdpd')
  end
end