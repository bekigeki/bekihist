# bekihist

Tools for deduplicating and importing BeKiGeKi Excel masks from multiple cohorts into a single scientific use file with minimally processed raw data. The package focuses on reproducible reading, and snapshot export (CSV/RDS) so that further tidying, harmonization, and analysis can be performed downstream in separate workflows.

Die Funktions- und Datensatzdokumentation des Pakets ist auf Deutsch verfasst.

The package focuses on:
- Reading cohort-specific Excel templates
- Binding multiple cohort files
- Producing reproducible CSV/RDS exports for downstream analysis

## Installation

Installation of the development version of **bekihist** from GitHub:

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
vignette("scientific-use-file")

# beki_scientific_use_file currently upon request only

``` 

## License

- Code: MIT
- Docs / vignettes: CC BY 4.0
  
