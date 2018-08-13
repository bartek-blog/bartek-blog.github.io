---
layout: post
comments: true
title:  "How to render Rmd"
date:   2018-07-09 10:00:00 +0200
categories: R
---

The library `rmarkdown`

* <https://rmarkdown.rstudio.com/>
* <https://cran.r-project.org/web/packages/rmarkdown/rmarkdown.pdf>


``` r

rmarkdown::render("input.Rmd", md_document())
rmarkdown::render("input.Rmd", md_document(variant = "markdown_github"))
```

``` shell
R -e rmarkdown::render("input.Rmd", md_document(variant = "markdown_github"))
```
