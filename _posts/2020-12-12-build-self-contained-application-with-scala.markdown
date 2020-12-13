---
layout: post
comments: true
title:  "How to build self-contained spark application with scala"
date:   2020-12-11 23:30:00 +0200
categories: [intelij, scala]
---

## Create scala aplication

You can do this directly with `sbt`, see
[How to create scala project with sbt]({% post_url 2018-07-09-how-to-create-scala-project-with-sbt %}),
or with IntelliJ, see
[How to install IntelliJ Community Edition for Scala on mac]({% post_url 2020-12-11-intelij %}),

## Set up dependencies

In `build.sbt` add

``` scala
name := "Hello Spark"

version := "0.1"

scalaVersion := "2.12.10"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.8" % Test
```

## Define new class

Create file `src/main/scala/SimpleSpark.scala` with

``` scala
import org.apache.spark.sql.{SparkSession, Row}
import org.apache.spark.sql.types.{StructType, StructField, StringType, IntegerType}
import org.apache.spark.sql.functions.{col, sum, pow, lit}

object SimpleSpark {
  def main(args: Array[String]) {

    val spark = SparkSession.builder.appName("Hello Spark").getOrCreate()

    val userData = Seq(
      Row("user1", 1),
      Row("user2", 2),
      Row("user1", 3),
      Row("user3", 4)
    )

    val userSchema = List(
      StructField("userId", StringType, true),
      StructField("spend", IntegerType, true)
    )

    val dataset = spark.createDataFrame(
      spark.sparkContext.parallelize(userData),
      StructType(userSchema)
    )

    val x = dataset.select(
        sum(pow(col("spend"), lit(2))).alias("sumSquares")
    ).collect()

    println("*********************")
    println(s"Sum of squares is ${x(0)}")
    println("*********************")

    spark.stop()
  }
}
```

## Build package

``` shell
sbt package
```

## Run with local spark

``` shell
$SPARK_HOME/bin/spark-submit \
  --class "SimpleSpark" \
  --master local \
  target/scala-2.12/hello-spark_2.12-0.1.jar
```

_Updated: 2020-12-13_
