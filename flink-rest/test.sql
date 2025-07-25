CREATE CATALOG iceberg_rest WITH (
  'type' = 'iceberg',
  'catalog-type' = 'rest',
  'uri' = 'http://iceberg-rest:8181',
  'warehouse' = 's3a://warehouse',
  's3.endpoint' = 'http://minio:9000',
  's3.access-key' = 'minioadmin',
  's3.secret-key' = 'minioadmin',
  'fs.s3a.impl' = 'org.apache.hadoop.fs.s3a.S3AFileSystem',
  's3.region' = 'us-east-1',
  's3.path-style-access' = 'true'
);

USE CATALOG iceberg_rest;

CREATE DATABASE IF NOT EXISTS demo;

USE demo;

CREATE TABLE customers (
                           id BIGINT,
                           name STRING,
                           email STRING
) PARTITIONED BY (email);

INSERT INTO customers VALUES
                          (1, 'Alice Smith', 'alice@example.com'),
                          (2, 'Bob Johnson', 'bob@example.com'),
                          (3, 'Carol Adams', 'carol@example.com');

SELECT * FROM customers$snapshots;

INSERT INTO customers VALUES
                          (4, 'Diana Brooks', 'diana.brooks@example.com'),
                          (5, 'Roy Martinez', 'roy.martinez@example.com'),
                          (6, 'Bobby Chen', 'bobby.chen@example.com'),
                          (7, 'Raymond Singh', 'ray.singh@example.com'),
                          (8, 'John Taylor', 'john.taylor@example.com');

SELECT *,
       UNIX_TIMESTAMP(CAST(committed_at AS STRING)) * 1000 AS committed_unix_ms
FROM customers$snapshots;

SELECT * FROM customers /*+ OPTIONS ('as-of-timestamp' = '1752189366000') */;

SELECT * FROM customers /*+ OPTIONS ('snapshot-id' = '857744417093019701') */;
