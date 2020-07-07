---
title: 06 - Analytics
---

## Amazon Athena

* Amazon Athena is an interactive query service that utilizes Schema-On-Read, allowing you to run ad-hoc SQL like queries on data from a range of sources
* Athena is used to query large dataset (structured, semi-structured, and unstructured) stored in S3 with infrequent access pattern
* You are charged for compute time only. You don’t need to maintain separate dataset for Athena, it can directly access S3 bucket

---

## Amazon EMR

*  EMR is tool for large-scale parallel processing of big data and other large data workloads
*  It is based on the Apache Hadoop framework and is delivered as a managed cluster using EC2 instances
*  It is used for huge-scale log analysis, indexing, machine learning, financial analysis, simulations, bio-informatics and many other large-scale applications
*  EMR cluster have zero or more core nodes, which are managed by the master node. They run tasks and manage data for HDFS
*  Data can be input from and output to S3. Intermediate data can be stored using HDFS in the cluster or EMRFS using S3.

---

## Amazon Kinesis

* Streaming service designed to ingest large amounts of data from hundreds, thousands or even millions of producers
* Scalable and Resilient
* Consumers can access a rolling window of that data, or it can be stored in persistent storage of database products

### Kinesis Data Stream

* A Kinesis data stream can be used to collect, process, and analyze a large amount of incoming data
* Storage for all incoming data within a 24 hour default window, which can be increased to seven days for an additional charge
* Kinesis Data records (The basis entity written to and read from Kinesis stream, a data record can be up to 1 MB in size) are added by producers and read by consumers

### Kinesis Data Firehose

* Reliably load streaming data into data lakes, data stores and analytics tools
* It can capture, transform, and load streaming data into Amazon S3, Amazon Redshift, Amazon Elasticsearch Service, and Splunk
* It enables near real-time analytics with existing business intelligence tools and dashboards you’re already using today
* Kinesis Data Streams can be used as the source(s) to Kinesis Data Firehose
* Pay for only the data ingested
  
### Kinesis Data Analytics

* Process and analyze real-time, streaming data
* Can use standard SQL queries to process Kinesis data streams
* A Kinesis Data Analytics application consists of three components:
    * Input – the streaming source for your application
    * Application code – a series of SQL statements that process input and produce output
    * Output – one or more in-application streams to hold intermediate results

### Kinesis Video Analytics

* Securely ingests and stores video and audio encoded data to consumers such as SageMaker, Rekognition or other services to apply Machine Learning and Video processing
---
