# Docker for PySpark

## To get build it

```bash
docker build -t spark_docker_v1 .
```

## How to run it

```bash
docker run --rm -it -p 4040:4040 spark_docker_v1
```

### To test it

Run the following and view it on <http://localhost:4040> you can download more data from here <https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/fhv>

```python
import pyspark
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .master("local[*]") \
    .appName('tepst') \
    .getOrCreate()

df = spark.read \
    .option("header", "true") \
    .csv('fhv_tripdata_2021-01.csv.gz')

df.show(100)
```

To show with filter

```python
df.filter("SR_Flag is not null").show(100)

df.filter("DOLocationID = 254").show(100)

```

To change types

```python
from pyspark.sql.types import IntegerType, BooleanType, DateType

df.printSchema()
df2 = (df \
.withColumn("pickup_datetime", df.pickup_datetime.cast('date')) \
.withColumn("dropoff_datetime", df.dropoff_datetime.cast('date')) \
.withColumn("PULocationID", df.PULocationID.cast('int')) \
.withColumn("DOLocationID", df.DOLocationID.cast('int')) 
)
df2.printSchema()
```