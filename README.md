# ImageX

ImageX is a simple BMP image filter utility written in C. It reads a 24-bit uncompressed BMP file, applies one of four image filters, and writes the transformed image back to a new BMP file.

## Features

- `-g` : grayscale filter
- `-r` : horizontal reflection filter
- `-b` : blur filter
- `-e` : edge detection filter
- `-s` : sepia filter

## Project layout

- `filter.c` : main program, argument parsing, BMP validation, and file I/O
- `helpers.c` : filter implementations for grayscale, reflect, blur, and edges
- `helpers.h` : function declarations for image filters
- `bmp.h` : BMP file format type definitions
- `Makefile` : build rule for compiling the `filter` executable
- `images/` : sample input BMP files (if present)
- `sample_output/` : expected output images for filters (if present)

## Build

From the project root folder, run:

```bash
make
```

This compiles the executable named `filter` using `clang` and the source files `filter.c` and `helpers.c`.

## Usage

```bash
./filter [flag] infile outfile
```

- `flag` : one of `-g`, `-r`, `-b`, `-e` or `-s`
- `infile` : path to a 24-bit uncompressed BMP input file
- `outfile` : path to write the resulting BMP image

### Example

```bash
./filter -g images/input.bmp output.bmp
```

This reads `images/input.bmp`, applies grayscale, and writes the result to `output.bmp`.

## Supported BMP format

The program accepts only BMP files that match all of these conditions:

- BMP signature `0x4d42`
- `BITMAPFILEHEADER.bfOffBits == 54`
- `BITMAPINFOHEADER.biSize == 40`
- `BITMAPINFOHEADER.biBitCount == 24`
- `BITMAPINFOHEADER.biCompression == 0`

If the input file does not meet these requirements, the program exits with `Unsupported file format.`

## Filters

- `-g` — grayscale
  - Converts each pixel to an average of its red, green, and blue values
- `-r` — reflect
  - Flips the image horizontally
- `-b` — blur
  - Applies a simple box blur using the surrounding 3x3 pixel neighborhood
- `-e` — edges
  - Detects edges using a Sobel-like gradient operator in both x and y directions
- `-s` — sepia
  - Applies the sepia filter to give a vintage like feel to the image using a fixed weighted formula

## Error cases

The program returns and prints an error if:

- an invalid filter flag is provided
- more than one filter flag is given
- the argument count is incorrect
- the input file cannot be opened
- the output file cannot be created
- the BMP file format is unsupported
- the image cannot be loaded into memory

## Notes

- Only one filter may be used per invocation.
- The output is always written as a BMP file with the same header format as the input.
- A MATLAB/Octave version implementation is also done named as `matlab_filter.m` which can be run using octave. It has additional features. For more details please refer `MATLAB_VERSION.md`

## Acknowledgments

This project is based on the "Filter (More)" assignment from Harvard's CS50x course.  
All original problem design and specification credit goes to Harvard University.

For more information, visit: [CS50x Filter (More)](https://cs50.harvard.edu/x/psets/4/filter/more/)
