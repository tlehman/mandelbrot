package main

import "C"
import (
	"fmt"
	"image"
	"image/color"
	"image/png"
	"math/cmplx"
	"os"
)

const w = float64(800)
const h = float64(800)
const MAX_ITERS = 200

func transform(row int, col int) complex128 {
	var y = 2 * (float64(col) - w/2.0) / w
	var x = -2 * (float64(row) - h/4.0) / h
	return complex(x, y)
}

func colorOf(row int, col int) uint8 {
	c := transform(row, col)
	var z complex128 = c
	for i := 0; i < MAX_ITERS || cmplx.Abs(z) > 2; i += 1 {
		z = z*z + c
	}

	if cmplx.Abs(z) < 2 {
		return uint8(0)
	} else {
		return uint8(255)
	}
}

func writeMandelbrotImageToFile() {
	m := image.NewRGBA(image.Rect(0, 0, int(w), int(h)))
	for i := 0; i < int(w); i += 1 {
		for j := 0; j < int(h); j += 1 {
			c := colorOf(i, j)
			m.Set(i, j, color.RGBA{c, c, c, 255})
		}
	}
	file, err := os.Create("pure-go.png")
	if err != nil {
		fmt.Printf("%v\n", err)
	}
	defer file.Close()
	enc := png.Encoder{CompressionLevel: -1}
	enc.Encode(file, m)
}

func main() {
	writeMandelbrotImageToFile()
}
