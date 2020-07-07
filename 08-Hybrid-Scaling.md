---
title: 08 - Hybrid and Scaling
---

## Snowball and Snowball Edge

* Snowball and Snowball Edge is a rugged container which contains a storage device
* It is used to move large amount of data quickly in and out of AWS. You can both export or import data using Snowball or Snowmobile
* Snowball and Snowball Edge is peta-scale migration; Snowmobile is for exabyte-scale migration
* Snowball comes in two sizes:
  * 50 TB (42 TB of usable space)
  * 80 TB (72 TB of usable space)
* Snowball Edge comes in two sizes:
  * 100 TB (83 TB of usable space)
  * 100 TB Clustered (45 TB per node)
* Snowball Edge includes both Storage and edge-computing workloads
* Snowball Edge provides three options
  * Edge Storage Optimized (24 vCPU)
  * Edge Compute Optimized (52 vCPU))
  * Edge Compute Optimized with GPU
* Snowball and Snowball Edge are idea for data transfer from 10 TB to 10 PB of data transfer

## Snowmobile

* It is 45 foot long ruggedize shipping container, pulled by a semi-trailer truck
* Snowmobile comes in one size: 100 PB
* Available in certain areas via special order from AWS
* Ideal for greater than 10PB Data Transfer for a single location
* Situated on side and connected into your data center for the duration of the transfer