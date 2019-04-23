## Hello World

See <https://spark.apache.org/docs/latest/quick-start.html>

``` python
from pyspark.sql import SparkSession
import pyspark.sql.functions as F

spark = SparkSession.builder.appName("SimpleApp").getOrCreate()

df = spark.createDataFrame(
    [(0, 0, 4.0), (0, 1, 2.0), (0, 3, 3.0), (1, 0, 4.0), (1, 1, 1.0), (1, 2, 5.0)],
    ["user", "item", "rating"]
)

df_pandas = df.groupBy("user").agg(F.count(F.col("item"))).toPandas()
print(df_pandas)

spark.stop()
```

## Sending job

``` shell
$SPARK_HOME/bin/spark-submit sample_app.py
```

If you test it locally and you have configured `pyspark` to work with `jupyter` then you have to reset two variables by

``` shell
unset PYSPARK_DRIVER_PYTHON
unset PYSPARK_DRIVER_PYTHON_OPTS
```
