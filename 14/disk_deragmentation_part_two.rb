require 'minitest/autorun'

class Grid
  attr_reader :rows

  def initialize
    @visited = {}
  end

  def add_row(row)
    @rows ||= []
    @rows << row
  end

  def count_groups
    groups = 0

    @rows.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        next if cell == '0'
        next if @visited[[x, y]]

        visit(x, y)
        groups += 1
      end
    end

    groups
  end

  def visit(x, y)
    return if @visited[[x, y]]
    return if @rows[x][y] == '0'

    @visited[[x, y]] = true

    if x > 0
      visit(x - 1, y)
    end

    if y > 0
      visit(x, y - 1)
    end

    if x < 127
      visit(x + 1, y)
    end

    if y < 127
      visit(x, y + 1)
    end
  end
end

def solution(input)
  grid = Grid.new

  128.times do |row|
    string = "#{input}-#{row}"
    hash = knot_hash(string)
    grid.add_row(hash.chars.collect{ |h| h.hex.to_s(2).rjust(4, '0') }.join.chars)
  end

  grid.count_groups
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
    assert_equal 1242, solution('flqrgnkx')
  end

  def test_solution
    assert_equal 1212, solution('jzgqcdpd')
  end
end