---
layout: post
comments: true
title: "Install and Run SparkR - easy way"
date:   2018-08-14 00:00:00 +0200
categories: sparkR
---

## Requirements

First, you must have R and java installed. This is a bit out the scope
of this note, but let me cover it a bit.

### Installing Java on Ubuntu:

    sudo add-apt-repository ppa:webupd8team/java
    sudo apt update
    sudo apt install oracle-java8-installer

You can manage java version by calling

    sudo update-alternatives --config java

and editing:

    sudo nano /etc/environment

by adding line

    JAVA_HOME="/usr/lib/jvm/java-8-oracle"

Then test it by calling

    source /etc/environment
    echo $JAVA_HOME
    java -version

### Installing R on Ubuntu

<https://launchpad.net/~marutter/+archive/ubuntu/c2d4u>

    sudo add-apt-repository ppa:marutter/c2d4u
    sudo apt update
    sudo apt install r-base r-base-dev

### Installing Rstudio on Ubuntu

    sudo apt-get install gdebi-core
    
    wget https://download1.rstudio.org/rstudio-xenial-1.1.453-amd64.deb
    sudo gdebi rstudio-xenial-1.1.453-amd64.deb
    rm rstudio-xenial-1.1.453-amd64.deb

### Installing rJava

Next, you have to see if you can install R interface to java. This can
be done by calling

    sudo R CMD javareconf

Now you can install `rJava` in R :

    install.packages("rJava")

Depending or your Operating System this can produce an error, and some
extra action would be required. Please google something like `rJava
install error ubuntu` etc.

Test it in R by calling, for example:

``` r
library(rJava)
.jinit()
Double <- J("java.lang.Double")
d <- new(Double, "10.2")
d
```

    ## [1] "Java-Object{10.2}"

### R and rJava on Mac

<https://github.com/snowflakedb/dplyr-snowflakedb/wiki/Configuring-R-rJava-RJDBC-on-Mac-OS-X>

### Other packages

You can also install few packages we may use in presentation. Simply
call:

    install.packages(c("rmarkdown", "ggplot2", "magrittr", "whisker", "data.table"))

  - `rmarkdown`: package that makes possible to create this document
  - `ggplot2`: popular graphing package,
  - `magrittr`: nicer functions chaining
  - `whisker`: it’s Movember
  - `data.table`, `reshape2`: an alternative for “data.frame”

## Download Spark

The easiest way to downloading spark is getting pre-bulid version from
\[<http://spark.apache.org/downloads.html>\].

### Mac

<https://www.r-bloggers.com/six-lines-to-install-and-start-sparkr-on-mac-os-x-yosemite/>

## SparkR test drive

The way we use SparkR here is far from being en example of *best
practice*. Not only because it does not run on more than one computer,
but also because we isolate the SparkR package from other packages by
hardcoding library path. This should help you set up you Spark(R) fast
for test drive.

Lets say you have downloaded and uncompress it to the folder

`/Users/bartek/programs/spark-2.3.0-bin-hadoop2.7`

So every time you see this path please change it to the one you have
(windows users have to probably change also slashes `/` to backslashes
`\` and add something like `/C/`)

Then try to run the following code in R:

``` r
spark_path <- '/Users/bartek/programs/spark-2.3.0-bin-hadoop2.7'
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = spark_path)
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
```

    ## 
    ## Attaching package: 'SparkR'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     cov, filter, lag, na.omit, predict, sd, var, window

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.data.frame, colnames, colnames<-, drop, endsWith,
    ##     intersect, rank, rbind, sample, startsWith, subset, summary,
    ##     transform, union

``` r
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))
```

    ## Spark package found in SPARK_HOME: /Users/bartek/programs/spark-2.3.0-bin-hadoop2.7

    ## Launching java with spark-submit command /Users/bartek/programs/spark-2.3.0-bin-hadoop2.7/bin/spark-submit   --driver-memory "2g" sparkr-shell /var/folders/w1/mtb5t1yd28l4kwz656bvhtmw0000gn/T//RtmpcsnUzw/backend_port7115ccd51ed

    ## Java ref type org.apache.spark.sql.SparkSession id 1

``` r
library('magrittr')
```

    ## 
    ## Attaching package: 'magrittr'

    ## The following object is masked from 'package:SparkR':
    ## 
    ##     not

``` r
library('ggplot2')

df <- as.DataFrame(mtcars)
model <- glm(mpg ~ wt, data = df, family = "gaussian")
summary(model)
```

    ## 
    ## Deviance Residuals: 
    ## (Note: These are approximate quantiles with relative error <= 0.01)
    ##     Min       1Q   Median       3Q      Max  
    ## -4.5432  -2.6110  -0.2001   1.2973   6.8727  
    ## 
    ## Coefficients:
    ##              Estimate  Std. Error  t value   Pr(>|t|)
    ## (Intercept)   37.2851      1.8776   19.858  0.000e+00
    ## wt            -5.3445      0.5591   -9.559  1.294e-10
    ## 
    ## (Dispersion parameter for gaussian family taken to be 9.277398)
    ## 
    ##     Null deviance: 1126.05  on 31  degrees of freedom
    ## Residual deviance:  278.32  on 30  degrees of freedom
    ## AIC: 166
    ## 
    ## Number of Fisher Scoring iterations: 1

``` r
predictions <- predict(model, newData = df)
class(predictions)
```

    ## [1] "SparkDataFrame"
    ## attr(,"package")
    ## [1] "SparkR"

``` r
predictions %>%
  select("wt", "mpg", "prediction") %>%
  collect %>%
  ggplot() + geom_point(aes(wt, prediction - mpg))  +
  geom_hline(yintercept=0) + theme_bw()
```

![](2018-08-14-install-sparkR_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Sparklyr

One can also install sparklyr. First we install devtools.

    install.packages("devtools")
    devtools::install_github("hadley/devtools") ## for latest version
    devtools::install_github("rstudio/sparklyr")
    devtools::install_github("tidyverse/dplyr")

Check available versions:

``` r
library(sparklyr)
spark_available_versions()
```

    ##    spark
    ## 1  1.6.3
    ## 2  1.6.2
    ## 3  1.6.1
    ## 4  1.6.0
    ## 5  2.0.0
    ## 6  2.0.1
    ## 7  2.0.2
    ## 8  2.1.0
    ## 9  2.1.1
    ## 10 2.2.0
    ## 11 2.2.1
    ## 12 2.3.0

``` r
spark_install(version = "2.3.0")
```

### sparkR in sparklyr

``` r
library(sparklyr)
sc <- spark_connect(master = "local")
spark_path = sc$spark_home
spark_disconnect(sc)

Sys.setenv(
  SPARK_HOME=spark_path
)
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))
```

    ## Java ref type org.apache.spark.sql.SparkSession id 1

## Contact

<bartekskorulski@gmail.com>

*Updated 2018-08-19*
