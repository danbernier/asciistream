def map(v, amin, amax, bmin, bmax)
  v = v.to_f
  pos = (v - amin) / (amax - amin)
  ((bmax - bmin) * pos) + bmin
end

width = (ARGV.first || 80).to_i

theta = 0.0
d_theta = 0.05

maxlines = 1000
maxlines = nil

chars = %w(. , - ; o a # @)

while true && (maxlines.nil? || (maxlines -= 1) > 0) do
  sin = Math.sin(theta)

  x = map(sin, -1, 1, 0, width).round
  # print x
  # print ' '

  line = ' ' * width
  line[x] = '*'

  puts line

  theta += d_theta
  sleep 0.01
end



puts
