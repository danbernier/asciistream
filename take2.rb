def map(v, amin, amax, bmin, bmax)
  v = v.to_f
  amin = amin.to_f
  amax = amax.to_f
  bmin = bmin.to_f
  bmax = bmax.to_f
  pos = (v - amin) / (amax - amin)
  ((bmax - bmin) * pos) + bmin
end

class Anim
  def initialize(w, h)
    @width = w
    @height = h
    blank!
  end
  attr_reader :width, :height

  def update; end

  def set(x, y, chr)
    if 0 <= y && y < @grid.size && 0 <= x && x < @grid.first.size
      @grid[y][x] = chr
    end
  end

  def blank!
    @grid = Array.new(height) do
      Array.new(width) { ' ' }
    end
  end

  def ellipse(cx, cy, w, h)

  end

  def to_s
    line = '-' * width
    ([line] + @grid.map { |r| "|" + r.join('') + "|" } + [line]).join("\n")
  end
end

class Target < Anim
  def initialize(w, h)
    super(w, h)
    @angle = 0
  end

  def update
    @angle += 0.05

    [0.95, 0.8, 0.65, 0.45, 0.3, 0.15].each do |rad|
      x = (Math.cos(@angle) * (width * rad * 0.5)).round
      y = (Math.sin(@angle) * (height * rad * 0.5)).round
      set(x + (width / 2.0), y + (height / 2.0), '@')
    end
  end
end

class Lissajous < Anim
  def initialize(w, h)
    super(w, h)
    @xt = 0
    @yt = 0
  end

  def update
    @xt += 0.1
    @yt += 0.07

    x = (Math.cos(@xt) * (width * 0.47)).round
    y = (Math.sin(@yt) * (height * 0.47)).round
    set(x + (width * 0.5), y + (height * 0.5), '~')
  end
end

class Ripples < Anim
  def initialize(w, h)
    super(w, h)
    @angle = 0
  end

  def update
    @angle += 0.1

    0.upto(width * height) do |rad|
      radangle = map(rad, 0, width*height, 0, 750 * Math::PI)
      osc = Math.sin(radangle)
      density = map(osc, -1, 1, 0, 1)

      x = Math.cos(@angle) * rad
      y = Math.sin(@angle) * rad * 0.5

      set(x + width*0.5, y + height*0.5, char(density))
    end
  end

  def char(density)
    chars = '.,-;oa#@'.split('')
    index = map(density, 0, 1, 0, chars.size - 1).floor
    chars[index]
  end
end

anim = Ripples.new(120, 50)

while true
  anim.update
  puts anim
  sleep 0.05
end

puts
