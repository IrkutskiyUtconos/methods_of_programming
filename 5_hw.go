package main

import (
	"fmt"
	"math"
)

func polynomial(x float64, coefficients ...float64) float64 {
	result := 0.0
	for i, coef := range coefficients {
		power := len(coefficients) - i - 1
		result += coef * math.Pow(x, float64(power))
	}
	return result
}

func solve(rangeX [2]float64, precision float64, coefficients ...float64) []float64 {
	var roots []float64
	a, b := rangeX[0], rangeX[1]
	step := (b - a) / 100.0

	findRoots := func(start, end float64) {
		fa := polynomial(start, coefficients...)
		fb := polynomial(end, coefficients...)

		if fa*fb <= 0 {
			for math.Abs(end-start) > precision {
				mid := (start + end) / 2
				fmid := polynomial(mid, coefficients...)

				if polynomial(start, coefficients...)*fmid < 0 {
					end = mid
				} else {
					start = mid
				}
			}
			root := (start + end) / 2
			roots = append(roots, root)
		}
	}
	for x := a; x < b; x += step {
		findRoots(x, x+step)
	}

	findRoots(b-step, b)

	var uniqueRoots []float64
	for _, root := range roots {
		
		found := false
		for _, ur := range uniqueRoots {
			if math.Abs(ur-root) < precision {
				found = true
				break
			}
		}
		if !found {
			uniqueRoots = append(uniqueRoots, root)
		}
	}

	return uniqueRoots
}

func main() {
	// Пример 1: x² - x - 6 = 0
	roots1 := solve([2]float64{-5, 5}, 0.0001, 1, -1, -6)
	fmt.Println("Корни первого уравнения:", roots1) // Ожидаем [-2, 3]

	// Пример 2: x³ = 0
	roots2 := solve([2]float64{-5, 5}, 0.0001, 1, 0, 0, 0)
	fmt.Println("Корни второго уравнения:", roots2) // Ожидаем [0]
}
