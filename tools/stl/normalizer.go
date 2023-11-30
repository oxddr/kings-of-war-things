package main

import (
	"flag"
	"fmt"
	"os"
	"sort"
	"strings"

	"github.com/hschendel/stl"
)

func main() {
	// Define command-line flags
	inputFile := flag.String("input", "", "Input STL file path")
	outputFile := flag.String("output", "", "Output STL file path")
	flag.Parse()

	// Check if the input file flag is provided
	if *inputFile == "" {
		fmt.Println("Please provide the input STL file using the -input flag.")
		os.Exit(1)
	}

	// Parse the STL data
	stlModel, err := stl.ReadFile(*inputFile)
	if err != nil {
		fmt.Printf("Error decoding STL: %v\n", err)
		os.Exit(1)
	}

	sortTriangles(stlModel.Triangles[:], func(i, j int) bool {
		return lexicographicalCompare(stlModel.Triangles[i].Normal, stlModel.Triangles[j].Normal)
	})

	// Determine the output file path
	outputFilePath := *outputFile
	if outputFilePath == "" {
		// If output file path is not provided, append "_normalized" to the input file name
		baseFileName := strings.TrimSuffix(*inputFile, ".stl")
		outputFilePath = baseFileName + "_normalized.stl"
	}

	// Write the normalized STL content to the output file
	err = stlModel.WriteFile(outputFilePath)
	if err != nil {
		fmt.Printf("Error writing output STL file: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Normalized STL file saved to: %s\n", outputFilePath)
}

// sortTriangles sorts a slice of STL triangles based on the provided less function.
func sortTriangles[T stl.Triangle](triangles []T, less func(i, j int) bool) {
	sort.Slice(triangles, less)
}

// lexicographicalCompare compares two STL normal vectors lexicographically.
func lexicographicalCompare(v1, v2 stl.Vec3) bool {
	return v1[0] < v2[0] ||
		(v1[0] == v2[0] && v1[1] < v2[1]) ||
		(v1[0] == v2[0] && v1[1] == v2[1] && v1[2] < v2[2])
}
