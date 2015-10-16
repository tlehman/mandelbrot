require 'chunky_png'

MAX_ITERS = 200
width = 800
height = 800
png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)

# Returns matrix of colors representing boundary of mandelbrot set
#    black (0,0,0) is in the mandelbrot set
#    blue (0,0,255) diverges slowly from set
#    green (0,255,0) diverges mediumly from set
#    red (255,0,0) diverges quickly from set
#
# it assumes the zero point is (w/2, h/2) and that 0..w maps to -2..2
#                                                  0..h maps to -2..2
def mandelbrot_matrix(w, h)
  matrix = Array.new(h) { Array.new(w) }

  transform = lambda { |row, col|
    y = 2*(col-w/2.0)/w.to_f
    x = -2*(row-h/4.0)/h.to_f
    Complex.rect(x,y)
  }

  color = lambda { |row, col|
    # compute z -> z^2 + c, where c is the initial value in the complex plane
    c = transform.call(row, col)
    z = c
    MAX_ITERS.times { |_|
      z = z*z + c
      break if z.magnitude > 2
    }

    (z.magnitude < 2) ? 0 : 255
  }

  w.times do |col|
    h.times do |row|
      matrix[row][col] = color.call(row, col)
    end
  end

  matrix
end

m = mandelbrot_matrix(width,height)
width.times do |col|
  height.times do |row|
    c = m[row][col]
    png[row,col] = ChunkyPNG::Color.rgba(c,c,c, 255)
  end
end

png.save('pure-ruby.png', interlace: false)
