require 'minitest/autorun'

def solution(input)
  severity = 0
  firewalls = {}

  input.split(/\n/).each do |firewall|
    match = firewall.match(/^(\d+):\s(\d+)/)
    depth = match[1].to_i
    range = match[2].to_i
    firewalls[depth] = range
  end

  max_depth = firewalls.keys.max

  (max_depth + 1).times do |depth|
    range = firewalls[depth]
    next if range.nil?

    firewall_position = depth % (((range - 2) * 2) + 2)
    if firewall_position == 0
      severity += depth * range
    end
  end

  severity
end

class SolutionTest < ::MiniTest::Test
  def test_example_input
    input = <<EOS
0: 3
1: 2
4: 4
6: 4
EOS
    assert_equal 24, solution(input)
  end

  def test_solution
    input = <<EOS
0: 4
1: 2
2: 3
4: 5
6: 8
8: 6
10: 4
12: 6
14: 6
16: 8
18: 8
20: 6
22: 8
24: 8
26: 8
28: 12
30: 12
32: 9
34: 14
36: 12
38: 12
40: 12
42: 12
44: 10
46: 12
48: 12
50: 10
52: 14
56: 12
58: 14
62: 14
64: 14
66: 12
68: 14
70: 14
72: 17
74: 14
76: 14
80: 20
82: 14
90: 24
92: 14
98: 14
EOS
    assert_equal 1928, solution(input)
  end
end