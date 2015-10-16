# Mandelbrot set in Ruby and in Go

Generates a mandelbrot set image in pure Ruby, and one in pure Go,
results and speeds are compared.

![mandelbrot set](pure-ruby.png)

# Results

```
~/src/mandelbrot(master+)% time ruby mandelbrot.rb
ruby mandelbrot.rb  47.45s user 0.12s system 99% cpu 47.611 total

~/src/mandelbrot(master+*)% time ./mandelbrot
./mandelbrot  0.60s user 0.01s system 101% cpu 0.599 total
```

That Go version, without any concurrency is 79 times faster than the Ruby version.

# Dependencies

 - Go 1.5 (or higher)
 - Ruby 2.2 (or higher)
