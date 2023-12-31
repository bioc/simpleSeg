simpleSeg
======================================================

Overview
--------

**simpleSeg** provides a structured pipeline for segmentation of cellular tiff stacks and the normalization of features, priming cells for classification / clustering.

A brief preview of `simpleSeg` can be found [here](https://htmlpreview.github.io/?https://github.com/SydneyBioX/simpleSeg/blob/main/vignettes/simpleSeg.html), and integration with further analysis is explained in detail [here](https://github.com/SydneyBioX/spicyWorkflow).

Installation
--------
Install the package from Bioconductor.

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("simpleSeg")
```

Otherwise, install the development version from Github.

```r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("SydneyBioX/simpleSeg")
library(simpleSeg)
```

### Installation Problems

Usually caused by non-R dependencies being unavailable. Ensure that the following packages are installed on your system.

```
fftw, gdal, fortran, arrow
```

### Submitting an issue or feature request

`simpleSeg` is still under active development. We would greatly appreciate any and 
all feedback related to the package.

* R package related issues should be raised [here](https://github.com/SydneyBioX/simpleSeg/issues).
* For general questions and feedback, please contact us directly via [ellis.patrick@sydney.edu.au](mailto:ellis.patrick@sydney.edu.au).


## Author

* **Alexander Nicholls**
* **Ellis Patrick**  - [@TheEllisPatrick](https://twitter.com/TheEllisPatrick)
* **Nicolas Canete**
