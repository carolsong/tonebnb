#!/bin/bash

JARS=/usr/local/spark/lib/aws-java-sdk-1.7.4.jar
JARS=$JARS,/usr/local/spark/lib/hadoop-aws-2.7.1.jar
JARS=$JARS,/usr/local/spark/lib/postgresql-42.2.5.jar

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Project Directory: $PROJECT_DIR"

# Environment variables for spark application
export POSTGRES_HOST='10.0.0.5 '
export POSTGRES_DB='tonebnb'
export POSTGRES_PORT='5432'
export POSTGRES_USER='sa'
export POSTGRES_PWD='sa'
export PYSPARK_PYTHON=/usr/bin/python3

# Configure AWS access key here if to access the S3 files.
# export AWS_ACCESS_KEY_ID=<aws access key>
# export AWS_SECRET_ACCESS_KEY=<aws secret key>

SPARK_MASTER=spark://10.0.0.5:7077
SPAKR_SUBMIT=/usr/local/spark/bin/spark-submit
PY_SPARK=$PROJECT_DIR/clean_airbnb.py

if [ -z "$1" ]; then
    echo "No process specified. Please specify the process (e.g. process_incidents.py)"
    exit 1
fi

$SPAKR_SUBMIT --master "$SPARK_MASTER" --jars "$JARS" "$PROJECT_DIR/$1"