# think of all those crazy logs you've seen.

def osc(theta: 0, d_theta: 0.01, amp: 1.0, offset: 0)
  lambda do
    theta += d_theta
    (Math.sin(theta) * amp) + offset
  end
end

bits = osc(d_theta: 0.000001, amp: 2, offset: 4)

loop do

  # random walk:
  # bits = 'aaa'
  # if rand < 0.01
  #   bits += 'a'
  # elsif rand < 0.01
  #   bits = bits[0..-2]
  # end

  print "hello there how are you? "
  print 'a' * bits.call
end
