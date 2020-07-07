---
title: 05 - AWS Database Services
---

## Amazon RDS (Relational Database Service)

* RDS is a Database as a Service (DBaaS) product. It can be used to provision a fully functional database without the admin overhead traditionally associated with DB platforms
* RDS supports a number of database engines - MySQL, MariaDB, PostgreSQL, Oracle, Microsoft SQL Server, Aurora
* RDS can be deployed in single AZ or Multi-AZ mode (for resilience) and supports General purpose and Memory Optimized instances
* RDS instances are managed by AWS, you cannot SSH into the VM instances
* Primary use case for RDS are Relational, Transactional databases. Best for relational datastore requirements (OLTP)
* By default, Customer are allowed to have up to 40 RDS databases
* **Pricing** - RDS instances are charged based on
  * Instance Size
  * Provisioned storage (Not Used)
  * IOPS (io1)
  * Data Transfer Out
  * Any backups/snapshots beyond the 100% total database storage for a region
* RDS Supports encryption
  * Encryption can be configured when creating DB instances
  * Encryption can be added by taking a snapshot, making an encrypted snapshot, and creating a new encrypted instance from that encrypted snapshot
  * Once encrypted, encryption cannot be removed
* Automated backups to S3 occur daily and can be retained from 0 to 35 days. (0 means disabled)
* Manual snapshot are taken manually and exist until deleted, and point-in-time log-based backups are also stored on S3

### RDS Multi-AZ

* RDS can be provisioned in Single or Multi-AZ mode. Multi-AZ makes an exact copy of your data in another AZ
* Multi-AZ provisions a primary instance and a standby instance in a different AZ of the same region
* With MultiAZ you do not have access to secondary AZ
* Multi-AZ has Automatic Failover protection if one AZ goes down, failover will occur and the standby will be promoted to primary

### RDS Read Replica

* RDS Read Replicas are read-only copies of an RDS instance that can be created in the same region or a different region from the primary instance
* Read Replicas can be addressed independently (each having their own DNS name) and used for read workloads, allowing you to scale reads
* 5 Read Replicas can be created from a RDS instance, allowing a 5x increase in reads
* Unlike Multi-AZs, read replicas can be used across regions. They also can be within the same AZ or even across AZs
* The primary instance needs to have automatic backups enabled to use Read Replicas
* With read replicas, AWS takes care of the networking aspects needed for **asynchronous** syncing between the primary and secondary regions
* Read replica use cases
  * When needing a faster recovery time than restoration from a snapshot
  * When most of your DB usage is reading rather than writing, you can scale out your datbase instances for read-only purpose. (Horizontal Scaling)
  * Have a Global Resilience

---

## Amazon Aurora

* Amazon Aurora is a fully-managed, MySQL-compatible, relational database engine that combines the speed and availability of high-end commercial databases that needs to scale, with Automatic backups, high availability, and fault tolerance
* Aurora MySQL is 5x faster over regular MySQL and 3x faster over regular Postgres
* Aurora is 1/10th the cost over its competitors with similar performance and availability options
* Aurora uses a base configuration of a cluster, which consists of one more db instances and a cluster volume that spans multiple AZs, with each AZ having a copy of the db cluster data
* A cluster contains a single primary instance and zero or more replicas
* Aurora cluster volume automatically scale as the amount of data in your database increases, up to max of 64 TB
* AWS Aurora only bills for the consumed data, and it's constantly backed up to S3
* Aurora replicates 6 copies of your database across 3 availability zones (2 Copies of data are kept in each AZ with minimum of 3 AZ)
* Aurora Serverless


### Aurora Endpoints

* Cluster endpoint - Connects to the primary db instance for the db cluster. This endpoint is the one that can perform write operation
* Reader endpoint - Connects to the one of the available Aurora replicas for the database cluster
* Custom endpoint - Represents a set of database instances that you choose. When you connect to the endpoint, Aurora performs load balancing and chooses one of the instance in the group to handle the connection.
* Instance endpoint - Connects to a specific database instance within an Aurora cluster. The instance endpoint provides direct control over connections to the db cluster.

### Aurora Serverless

* On-demand, auto-scaling configuration for Amazon Aurora (MySQL-compatible and PostgreSQL-compatible editions)
* The database will automatically start up, shut down, and scale capacity up or down based on your application's needs
* It's a simple, cost-effective option for infrequent, intermittent, or unpredictable workloads
* Enabled you to run database in cloud without managing any database instances
* Pricing is based on per-second for the database capacity you use when the database is active

---

## DynamoDB

* DynamoDB is a fully managed NoSQL key/value and document database that provides fast and precedable performance with seamless scalability
* It’s a regional service, partitioned regionally and allows the creation of tables, hence tables names in DynamoDB have to be regionally unique
* DynamoDB can be set to have **Eventual Consistent Reads** (default) and **Strongly Consistent Reads**
* Eventual consistent reads data is returned immediately but data can be inconsistent. Strongly Consistent Reads will wait until data is consistent
* DynamoDb stores 3 copies of data on SSD drive across 3 regions
* Key Components
  * A **Table** is a collection of items that share the same partition key (PK) or partition key and sort key(SK) together with other configuration and performance settings
  * An **Item** is a collection of attributes (up to 400 KB in size) inside a table that shares the same key structure as every other items in the table
  * **Attribute** is a fundamental data element which consists of key and value
  * **Primary Key** is a unique identifier for the items in the table
  * **Partition Key** and Sort Key is composed of two of more attributes
  * **Secondary Indexes** allows you to query the data in the table using the alternate key

### DynamoDB Indexes
* Indexes provide an alternative representation of data in a table, which is useful for application with varying query demands
* Indexes come in two forms: Local Secondary Indexes (LSI) and Global Secondary Indexes (GSI)
* Indexes are interacted with as though they are table, but they are just an alternate representation of data in an existing table
* There are two types of Secondary Indexes
  * Global Secondary Index (GSI) - An index with a partition key and sort key that can be different from that on the table
  * Local Secondary Index (LSI) - An index that has the same partition key as the table, but a different sort key
* LSIs must be created at the time of creation of table. GSI can be created at any point after the table is created.
* You can define up to 20 GSI and 5 LSI per table

### DynamoDB Streams

* When enabled, streams provide an ordered list of changes that occur to items within a DynamoDB table
* A stream is a rolling 24-hour window of changes
* Streams are enabled per table and only contain data from the point of being enabled.
* Streams can be configured with one of four view types:
  * `KEYS_ONLY` - Whenever an item is added, updated or deleted, the key(s) of that item are added to the stream.
  * `NEW_IMAGE` - The entire item is added to the stream “post-change”
  * `OLD_IMAGE` - The entire item is added to the stream “pre-change”
  * `NEW_AND_OLD_IMAGES` - Both the new and old versions of the items are added to the stream.
* Streams can be integrated with AWS Lambda, invoking a function whenever items are changed in a DynamoDB table (a DB trigger)

### DynamoDb Performance and Billing

* DynamoDB has two read/write capacity modes: **Provisioned throughput** (default) and **On-Demand** mode
* When using On-Demand mode, DynamoDB automatically scales to handle performance demands and bills a per-request charge
* When using Provisioned throughput mode, each table is configured with read capacity units (RCU) and write capacity units (WCU)

## Database Migration Service (DMS)

* DMS is a service to migrate relational database, To and From from any location with network connectivity to AWS
* DMS is compatible with a broad range of DB Sources, including Oracle, MS SQL, MySQL, MariaDB, PostgreSQL, MongoDB, Aurora, and SAP
* Data can be synced to most of the above engines, as well as Redshift, S# and DynamoDB
*  DMS is useful in a number of common scenarios:
   * Scaling database resources up and down without downtime
   * Migrating databases from on-premises to AWS, from AWS to on-premises or to/from other cloud platforms
   * Moving data between different DB engines, including schema conversion
   * Partial / subset data migration
   * Migration with little to no admin overhead, as a service

