---
title: 01 - AWS Compute Services
---


## Elastic Cloud Compute (EC2)

* EC2 is a Cloud Computing Service. It is responsible for providing long-running compute as service.
* Configures your EC2 by choosing your OS, Storage, Memory, Network Throughput
* EC2 comes in variety Instance types of specialization for different roles **[EC2 Families]**
  * **General Purpose** - Balance of Compute, Memory and Networking resources
  * **Compute Optimized** - Ideal for compute based application that benefit from high performance processor
  * **Memory Optimized** - Ideal for fast performance workloads processing large data sets in memory
  * **Storage Optimized** - Ideal for high sequential, read and write access to very large dataset on local storage
  * **Accelerated Optimized** - Hardware accelerators, or, co-processors
* Instance sizes include Nano, Small, Medium, Large, X.Large, 2X.Large and Larger

### Instance Profile

* Instance Profiles is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts.
* An instance profile is either created automatically when using the console UI or manually when using the CLI.
* EC2 instance roles are IAM roles that are "assumed" by EC2 using intermediary called an Instance Profile. 

### Instance Metadata

* Instance metadata can be used to access information about current instance from the instance.
* It allows applications running within EC2 to have visibility into their environment.
* E.g, curl `http://169.254.169.254/latest/meta-data` provides infromation about intance type, current ip etc.

### Placement Groups

* Let you choose the logical placement of your instances to optimize for network, performance or durability
* Placement groups are free of cost.

#### Cluster Placement Group (CPG)
* Places instances physically near other in a single availability zone
* It works with Enhanced Networking for deliverying maximum performance

#### Partition Placement Group (PPG)
* Instances deployed into a partition placement group are separated into partitions, each occupying isolated rack in AZs
* It minimizes failure in partition and provides visibility on placement

#### Spread Placement Group (SPG)
* Designed for max of seven (7) instances per AZ
* Each instance occupies a partition and has an isolated fault domain


### User Data

* When you launch an instance in Amazon EC2, you have the option of passing **User Data** to the instance that can be used to perform common automated configuration tasks and even run scripts after the instance starts.
* You can pass two types of user data to Amazon EC2: `shell scripts` and `cloud-init` directives

### EC2 Pricing

EC2 has 5 pricing models.

### On-Demand
* Pay for EC2 instances you use (Flexible) Pay per hour or second(Minimum of 60 sec)]
* Ideal when work-load cannot be interrupted
* The use of On-Demand instances frees you from the costs and complexities of planning, purchasing, and maintaining hardware
* Use Case - Short Term Instances, Spiky Traffic, First Time Applications (Unknown Demand)

### Reserved Instances
* You can save upto 75% off compared to on-demand instances
* Reserved instance lock in a reduced rate for one or three years
* Your commitment incurs costs even if instance aren’t launched
* Use Case - Long-running, Critical , Known / Understood, and Consistent workload systems

### Spot Instances
* You can save upto 90% compared to on-demand instances
* Allow consumption of spare AWS capacity at really reduced rate.
* Instances are provided to you as long as your bid price is above the spot price, and you only ever pay the spot price. If your bid is exceeded, instances are terminated with **two-minute-warning**
* Use Case - Non critical workoads, burst workloads or consistent non-critical workloads that can tolerate interruptions.
* Not good options for long running jobs that cannot tolerate interruptions.

### Savings Plans
* Flexible pricing model that offer low price on EC2 or Fargate usage, in exchange for a commitment to a consistent amoutn of usage (measured in $/hour) for a 1 or 3 year term

### Dedicated Hosts
* Dedicated host give you complete control over physical instance placement and dedicated hardware free from other customer interactions.
* Dedicated hosts are generally used when software is licensed per core/CPU and not compatibile with running within a shared cloud environment.
* Can be purchased On-Demand (Hourly)

---

## Amazon Machine Image (AMI)

* AMIs are used to build instances. They store snapshot of EBS volume, launch permission and block device mapping that specify the volumes to attach to the instance when it's launched.
* AMIs are regional service
* You can create an AMI from existing EC2 instnace that are in either running or stopped state
* Community AMIs are AMIs managed by public (community). These AMI come from AWS users, and are not verified by AWS
* AWS Marketplace - AMIs verified by AWS. AWS Marketplace consists of both Free as well as paid version of AMIs
* Two types of AMI
  * Instance Store Back AMIs - Root Volume doesn't use EBS
  * EBS Backed AMIs - Root Volume uses EBS
* AMIs are faster but compared to UserData, AMIs doesn't support dynamic configuration


---

## Amazon Elastic Block Storage (EBS)

* Storage service that **creates** and **manages** volumes
* EBS Volumes are durable block level storage device that you can attach to a single EC2 istance
* Volumes are persistent, can be attached and removed from EC2 instances, and are replicated within a single AZ
* EBS **Snapshots** are a point-in-time backup of an EBS volume stored in S3
* Snapshots are incremental - The initial snapshot is a full copy of the volume. Future snapshots only store the data changed since the last snapshot
* Snapshots can be used to create new volumes and are a great way to move or copy instances between AZs.
* When creating a snapshot of the root volume of an instance of busy volume, it’s recommended the instance is powered off, or disks are “flushed”
* Snapshots can be copied between regions, shared and automated using Data Lifecycle Manager (DLM)
* By defualt, root volumes are deleted on termination
* Volume encryption uses EC2 host hardware to encrypt data at rest and In-Transit between EBS and EC2 instances

### EBS Volume Types

* General Purpose SSD (gp2)
  * Default for most workloads
* Provisioned IOPS SSD (io1)
  * Used for applications that required sustained IOPS performance
  * Ideal for large database workloads
* Throughput Optimized HHD (st1)
  * Low cost volume storage
  * Used for frequently accessed, throughput-intensive workoads (Streaming, BigData)
  * Cannot be root volume
* Cold HDD (sc1)
  * Cheapest volume solution
  * Infrequent accessed data
  * Cannot be root volume

---

## AWS Lambda

* Serverless Compute service offering
* Lambda's are serverless functions. You don't need to manage or provision servers
* Lambda functions are stateless
* You choose the amount of memory you want to allocate to your functions and AWS Lambda allocates propotional CPU, Network, Bandwidth and Disk
* There are 7 runtime languages supported:
  * Ruby
  * Python
  * Java
  * NodeJS
  * C#
  * Powershell
  * Go
* Pricing - Pay per invocation (The duration and the amount of memory used) rounded up to the nearest 100 ms. First 1M requests per month are free
* You can adjust the duration timeout upto 15 minutes and memory upto 300 MB
* By default, AWS executes your Lambda function code securely within a VPC. Alternatively you can enable your Lambda function to access resource inside your private VPC by providing additional VPC specific configuration
* Labda is HA and scalable by design. Lambda can scale to 1000 os concurrent functions in seconds
* Lambdas have Cold Starts (delayed Initial Start), if a function has not been recently been executed.

---

## Amazon Elastic Container Service (ECS)

* ECS is a managed container service
* It allows docker containers to be deployed and managed within AWS environments
* ECS can use infrastructure cluster based on EC2 or Fargate
  * With EC2 launch type, you own EC2 instances
  * AWS Fargate is a managed service, so tasks are auto placed
* Amazon ECS is a regional service
* Components
  * **Cluster** - A logical collection of ECS resources - either ECS EC2 instances or a logical representation of managed Fargate infrastructure
  * **Task Definition** - Defines your application. Similar to Dockerfile but for running containers in ECS. Task definition can contain multiple containers
  * **Container Definition** - Inside a task definition, a container definition defines the individual containers a task uses. It controls the CPU and memory each container has, in addition to port mappings for the container
  * **Task** - A single running copy of any containers defined by a task definition. One working copy of an application
  * **Service** - Allows task definitions to be scaled by adding additional tasks. Define minimum and maximum values
  * **Registry** - Storage for container images. (eg. ECS Container Registry or Dockerhub). Used to download image to create containers

---

## Auto Scaling Groups (ASG)

* An ASG is a collection of EC2 instances grouped for scaling and management
* Metrics such as CPU utilization or network transfer can be used either to scale out or scale in using scaling policies
* Size of an ASG is based on a Min, Max and Desired Capacity (How many EC2 instances you want to ideally run)
* Auto Scaling Groups are often paired with ELB
* ASG uses launch configuration or launch template and allow automatic scale-out or scale-in based on configuration metrics
* Scaling can be Manual, Scheduled or Dynamic
* Scaling policy can be:
  * **Simple Scaling Policy** - Policy triggers a scaling when an alarm is breached
  * **Scaling Policy with Steps** - New version of Simple Scaling policy and allows you to create steps based on alarm values
  * **Target Scaling Policy** - Based on when a target value for a metrics is breached. e.g, Average CPU Utilization exceeds 90%
* Health checks determine the current state of an instance in the ASG
* Health checks can be run against either an ELB or the EC2 instances