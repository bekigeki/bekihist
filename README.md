# bekihist

Tools for binding BeKiGeKi Excel “masks”
into tidy R data frames for research and reporting.

The package focuses on:
- Reading cohort-specific Excel templates
- Binding multiple cohort files
- Producing reproducible CSV/RDS exports for downstream analysis

## Installation

You can install the development version of **bekihist** from GitHub:

```r
´´´`````r```r

```{r 2025, eval=FALSE}
# install.packages("pak")  # or remotes, devtools, etc.
pak::pak("bekigeki/bekihist")
``` 

## Example

```{r 2025, eval=FALSE}
library(bekihist)

# See the introductory vignette for binding files
vignette("getting-started")

# See how to bind a public-use or scientific-use file for
# further processing
vignette("public-use-file")

``` 

## License

- Code: MIT
- Docs / vignettes: CC BY 4.0
  
