---
title: 03 - AWS Storage
---

## Amazon S3

* Simple Storage Service (S3) is object based Storage Service.
* Stores **unlimited** amount of data without worrying about underlying infrastructure
* S3 replicates data across at least 3 AZ's to ensure 99.99% Availability and 99.99% (11 9's Durability)
* Objects can be from 0 Bytes up to 5 TB **(Multipart Upload)**. Single PUT upload support up to 5 GB
* For filesize greater than 100 MB, Multipart Uploads are recommended
* **S3 Transfer Acceleration** enables fast, easy, and secure transfers of files over long distances between your client and an S3 bucket.
* A **Presigned URL** is a temporary URL that allows users to see assigned S3 objects using the creator’s credentials. Presigned Urls are commonly used to access private objects.

### Buckets
* S3 stores data as objects within **buckets**. Buckets can also contain folders which can in turn contain objects
* Bucket name must be a unique DNS-complaint name
  * Bucket names are unique across all AWS accounts
  * After you create the bucket you cannot change the name
  * All new buckets are "private" by default.
* Access to S3 buckets are configured using **Bucket Policy** and **Access Control List (ACL)**. ACLs are legacy mechanism to handle access control

### Versioning

* Once versioning is turned On, Objects are given a VersionID
* When a new objects are uploaded the old objects are kept. You can access any object version
* With versioning enabled, an AWS account is billed for all versions of all objects
* Object deletions by default do not delete an object - instead a delete marker is added to indicate the object is deleted
* MFA Delete enforce DELETE operation to require MFA token in order to delete an object. To enable MFA delete, versioning should be turned on
* Once a bucket is version-enabled, it can never be fully switched off - only suspended.

### Amazon S3 Security
* As Data in Motion, all the data transfer coming in and out from S3 are encrypted with SSL
* Data at Rest can be configured per object basis using
  * AWS Managed Server Side Encryption - (SSE-KMS) - Envelope encryption via AWS KMS and you mange the keys
  * S3 Managed Server Side Encryption - (SSE-AES) - S3 handles the key, uses AES-256 algorithm
  * Client Side Encryption - Client is responsible for managing both encryption / decryption and it's keys

### Storage Classes

#### S3 Standard
* Default, all purpose storage or when usage is unknown
* 99.99 (11 nines) Durability and four nines Availability
* No minimum object size
* No retrieval fee

#### S3 Standard Infrequent Access (Standard-IA)
* For long-lived, but less frequently accessed data
* Stores the object data redundantly across multiple geographically separated AZs. (Replicated 3+ AZ)
* 30 Days and 128 KB minimum charge and object retrieval fee

#### S3 One Zone Infrequent Access (OneZone-IA)
* Less expensive than Standard-IA
* Data stored in only 1 AZ (99.5% Availability)
* Ideal for non mission critical and/or reproducible objects
* 30 Days and 128 KB minimum charge and object retrieval fee

#### Amazon S3 Intelligent Tiering
* Storage class designed for customer who want to optimize storage costs automatically when data access patterns change, without performance impact or operational overhead
* Automatically move data between Frequent access and infrequent access tiers
* S3 Intelligent-Tiering monitors access patterns and move objects that have not been accessed for 30 consecutive days to the infrequent access tier.

#### Glacier
* For long-term archival storage (warm and cloud backups)
* Archived objects are not available for real-time access. You must first restore the objects before you can access them
* 3+ AZ replication, 90 Days and 40KB minimum charge and retrieval fee

##### Glacier Deep Archive
* Long-term retention of data that is accessed rarely in a year
* Lowest cost storage
* 180 Days and 40KB minimum charge and retrieval fee


* **Storage Classes** can be controlled via Lifecycle Rules, which allow for the automated transition of object between storage classes, or in certain cases allow for the expiration of objects that are no longer required.


### S3 Cross Region Replication (CRR)

* Feature that can be enabled on S3 buckets allowing one-way replication of data from a source bucket to a destination bucket in another region
* You must have versioning enabled in the source and destination bucket to enable CRR
* You can have CRR replicate to bucket in another AWS Account
* Replication requires an IAM role with permission to replicate objects, With the replication configuration, it is possible to override the storage class and object permission as they are written to the destination.

---

## Amazon Elastic File System (EFS)

* EFS provides a simple, scalable, fully managed elastic NFS file system for use with AWS Cloud services, and on-premises resource
* It is a popular shared storage system that can be natively mounted as a file system within Linux instances
* With EFS, File system can be created and mounted on multiple Linux instances at the same time
* Amazon EFS offers two storage classes: The Standard storage class, Infrequent Access Storage Class
* EFS is designed for large scale parallel access of data.
* Ideal use cases include, Shared media, Logging solutions where various clients need to access Shared Data
* Amazon EFS is Region Resilient. Security groups are used to control access to NFS mount targets.

---

## AWS Storage Gateway

* Hybrid storage service that allows you to **migrate data** into AWS, extending your on-premises storage capacity using AWS
* There are three main types of Storage Gateway:
  * File gateway
  * Volume gateway
  * Tape gateway
* A File gateway supports a file interface into AWS S3 and combines a server and a virtual software appliance. Using File gateway, you can store and retrieve objects in Amazon S3 using NFS and SMB
* Volume Gateway provides cloud-backed storage volumes that you can mount as Internet Small Computer System Interface (iSCSI). The volume gateway is deployed into your on-premises environment as a VM running on VMWare ESXI, KVM or Microsoft Hyper-V hypervisor
* A tape gateway provides cloud-backed virtual tape storage. The tape gateway is deployed into your on-premises environment as a VM running on VMware ESXi, KVM or Microsoft Hyper-V hypervisor

