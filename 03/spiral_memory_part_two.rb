require 'minitest/autorun'

def solution(square)
  spiral = {
      [0, 0] => 1
  }

  coordinates = [0, 0]

  while spiral[coordinates] <= square
    coordinates = move(coordinates)
    spiral[coordinates] = get_value(coordinates, spiral)
  end

  spiral[coordinates]
end

def get_value(coordinates, spiral)
  value = 0
  x, y = coordinates

  [-1, 0, 1].each do |x_offset|
    [-1, 0, 1].each do |y_offset|
      value += spiral[[x + x_offset, y + y_offset]] || 0
    end
  end

  value
end

def move(coordinates)
  x, y = coordinates

  if x.abs == y.abs
    if x > 0 && y > 0
      return [x - 1, y] # left
    elsif x < 0 && y > 0
      return [x, y - 1] # down
    else
      return [x + 1, y] # right
    end
  elsif x.abs > y.abs
    if x > 0
      return [x, y + 1] # up
    else
      return [x, y - 1] # down
    end
  else
    if y > 0
      return [x - 1, y] # left
    else
      return [x + 1, y] # right
    end
  end
end

class SolutionTest < ::MiniTest::Test
  def test_solution
    assert_equal 363010, solution(361527)
  end
end