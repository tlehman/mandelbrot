require 'chunky_png'

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

  color = lambda { |row, col|
    # compute z -> z^2 + c, where c is the initial value in the complex plane

    [red, green, blue]
  }

  w.times do |col|
    h.times do |row|
      matrix[row][col] = color.call(row, col)
    end
  end
end

width.times do |col|
  height.times do |row|
    png[row,col] = ChunkyPNG::Color.rgba(col % 256, row % 256, (col+row) % 256, 128)
  end
end

png.save('pure-ruby.png', interlace: true)
