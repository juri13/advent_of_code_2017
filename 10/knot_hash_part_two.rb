require 'minitest/autorun'

def solution(input)
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
  def test_example_input_1
    assert_equal 'a2582a3a0e66e6e86e3812dcb672a272', solution('')
  end

  def test_example_input_2
    assert_equal '33efeb34ea91902bb2f59c9920caa6cd', solution('AoC 2017')
  end

  def test_example_input_3
    assert_equal '3efbe78a8d82f29979031a4aa0b16a9d', solution('1,2,3')
  end

  def test_example_input_4
    assert_equal '63960835bcdc130f0b66d7ff4f6a5a8e', solution('1,2,4')
  end

  def test_solution
    assert_equal 'd067d3f14d07e09c2e7308c3926605c4', solution('120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113')
  end
end