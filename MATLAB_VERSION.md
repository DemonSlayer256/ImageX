# ImageX (MATLAB/Octave Version)

ImageX is a command-line image processing toolkit built using GNU Octave.
It applies classic computer vision filters and basic image transformations directly from the terminal.

This version is a MATLAB/Octave rewrite of the original C-based ImageX implementation, designed for easier experimentation, vectorized operations, and extended functionality.

---

# Features

ImageX supports the following image processing operations:

### 🎨 Basic Filters

* Grayscale conversion
* Horizontal reflection
* Gaussian-style blur (box filter)
* Sepia tone transformation
* Edge detection (Sobel operator)

### ⚙️ Advanced Controls

* Brightness adjustment (user-defined)
* Contrast enhancement (user-defined)
* Binary thresholding (user-defined)

---

# Usage

## General Syntax

```bash
octave -qf image_filter.m <filter> <input_image> [value]
```

---

## Examples

### Basic Filters

```bash
octave -qf image_filter.m g images/courtyard.bmp
octave -qf image_filter.m e images/courtyard.bmp
octave -qf image_filter.m b images/courtyard.bmp
octave -qf image_filter.m s images/courtyard.bmp
octave -qf image_filter.m r images/courtyard.bmp
```

---

### Advanced Filters (with parameters)

#### 🔆 Brightness

```bash
octave -qf image_filter.m l images/courtyard.bmp 60
```

#### 🎯 Contrast

```bash
octave -qf image_filter.m c images/courtyard.bmp 1.8
```

#### 🔲 Threshold

```bash
octave -qf image_filter.m t images/courtyard.bmp 140
```

---

# Output Format

If no output filename is provided, ImageX automatically generates one using:

```text
<inputname>_<filter>_<value>.bmp
```

### Examples:

* `courtyard_brightness_60.bmp`
* `courtyard_contrast_1.8.bmp`
* `courtyard_threshold_140.bmp`
* `courtyard_edges.bmp`

---

# Design Overview

ImageX is designed to demonstrate:

* Vectorized image processing in Octave
* CLI-based tool design
* Modular filter architecture
* Efficient matrix-based computation

All filters operate on RGB matrices using standard linear algebra operations.

---

# Project Structure

```
ImageX/
│
├── image_filter.m      # Main CLI tool
├── test.sh             # Automated test script
├── images/             # Input images
└── outputs/            # Generated results (optional)
```

---

# Requirements

* GNU Octave
* Image Processing Package:

  ```matlab
  pkg load image
  ```

---
# Improvements Over C Version

Compared to the original C implementation:

* ✔ No manual memory management
* ✔ Faster prototyping using matrix operations
* ✔ Cleaner and more readable filters
* ✔ Easier experimentation with parameters
* ✔ Built-in image I/O support
* ✔ Vectorized computation for performance

---

# Supported Filter Flags

| Flag | Description    |
| ---- | -------------- |
| g    | Grayscale      |
| r    | Reflect        |
| b    | Blur           |
| e    | Edge detection |
| s    | Sepia          |
| l    | Brightness     |
| c    | Contrast       |
| t    | Threshold      |

---

# Author

Developed as part of ImageX project migration from C to MATLAB/Octave for image processing experimentation and computer vision fundamentals.

---