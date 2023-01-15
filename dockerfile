FROM python:3.9.1

RUN apt-get -y update
RUN apt-get -y install curl wget openjdk-11-jdk
RUN pip install pandas
RUN /usr/local/bin/python -m pip install --upgrade pip

COPY fhv_tripdata_2021-01.csv.gz .

# VERSIONS
ENV SPARK_VERSION=3.3.1 \
HADOOP_VERSION=3 \
JAVA_VERSION=11

# SET JAVA ENV VARIABLES
#ENV JAVA_HOME="/home/jdk-${JAVA_VERSION}.0.2"
#ENV PATH="${JAVA_HOME}/bin/:${PATH}"

# DOWNLOAD SPARK AND INSTALL
RUN DOWNLOAD_URL_SPARK="https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
    && wget --no-verbose -O apache-spark.tgz  "${DOWNLOAD_URL_SPARK}"\
    && mkdir -p /home/spark \
    && tar -xf apache-spark.tgz -C /home/spark --strip-components=1 \
    && rm apache-spark.tgz

# SET SPARK ENV VARIABLES
ENV SPARK_HOME="/home/spark"
ENV PATH="${SPARK_HOME}/bin/:${PATH}"

# SET PYSPARK VARIABLES
ENV PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
ENV PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9.5-src.zip:$PYTHONPATH"

# Let's change to  "$NB_USER" command so the image runs as a non root user by default
USER $NB_UID

#ENTRYPOINT ["python" ]