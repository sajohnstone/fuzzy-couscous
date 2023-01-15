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

Run the following and view it on http://localhost:4040 you can download more data from here https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/fhv

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

df.show()
```

