---
title: 04 - Network and Content Delivery
---

## Amazon CloudFront

* CloudFront is a CDN (Content Delivery Network). It makes website load faster by serving cached content
* Benefits of using CloudFront includes
  * Lower Latency
  * Higher Transfer Speed
  * Reduced load on Content Server
* **Origin** is the address of where the original copies of your files reside eg. S3, EC2, ELB
* **Distribution** defines a collection of Edge locations and behaviors on how it should handle your cached content
* Distribution has 2 types: Web Distribution (static website content) and RTMP (streaming media)
* **Edge Locations** are local infrastructure that hosts cache of data
* Origin Identity Access (OAI) is used to access private S3 buckets, restricting S3 bucket access only via Cloud Front
* Access to cached content can by protected via **Signed Urls** or **Signed Cookies**
* **Lambda@Edge** allows you to pass each request through a Lambda to change the behavior of the response

## Amazon Route 53

* Route53 is a DNS provider, register and manage domains, create record sets and health check of resources
* **Simple Routing** (Default) - A simple routing policy is a single record within a hosted zone that contains one or more values. When queried a simple routing policy record returns all the values in a randomized order.
* **Weighted Routing** - Weighted routing policy can be used to control the amount of traffic that reaches specific resources, based on different 'weights' assigned (Percentages). It can be useful when testing new software or when resources are being added or removed from.
* **Latency Based Routing** - Directs traffic based on region, for lowest possible latency for users
* **Failover Routing** - Failover routing allows you to create two records with same name. One is designed as the primary and another as secondary. Queries will resolve to the primary - unless it is unhealthy, in which the Route 53 will respond with the secondary.
* **Geolocation Routing** - Route traffic based on the geographic location of a requests origin
* **Traffic Flow** - Visual editor, for chaining routing policies, can version policy records for easy rollback
* AWS Alias Record - AWS's smart DNS record, detects changed IPs for AWS resources and adjusts automatically
* **Route53 Resolver** - Lets you regionally route DNS queries between your VPC and your on-premise network


## API Gateway

* Enabled developers to Create, Publish, Maintain, Monitor and secure APIs
* Api gateway can use other AWS Services
* With Lambda, API Gateway forms the front facing part of AWS serverless infrastructure
* Stages allow you to have multiple published version of your API. Eg, staging, QA, prod
* CORS issues are common with API Gateway, CORS can be enabled on all or individual endpoints
* With API Gateway, you can use setup cache with customizable keys and TTL for your API data
* API Gateway is integrated with CloudWatch, so you get backend performance metrics such as API calls, latency, and error rates
* API Gateway can also log API execution errors to CloudWatch Logs.


## AWS Direct Connect

* A Direct Connect (DX) is a physical connection between your network and AWS either directly via a cross-connect and customer router at a DX location or DX partner
* Ideal used for Higher throughput network traffic with low latency

## AWS Elastic Load Balancers (ELB)

* ELB is a service that provides a set of highly available and scalable load balancers in one of three versions: Classic (CLB), Application (ALB) and Network (NLB)
* ELBs can be paired with Auto Scaling groups to enhance high availability and fault tolerance - Automating scaling / Elasticity
* An elastic load balancer has a DNS record, which allows access to the external side
* ELBs cannot go cross-region. You must create one per region

### Classic Load Balancers
* CLB use Listeners and EC2 instances are directly registered as targets to CLB
* Support L3 and L4 (TCP and SSL) and some HTTP/S features
* Supports 1 SSL certificate per CLB - can get expensive for complex projects
* Sticky sessions can be enabled for CLB

### Application Load Balancers
* Operates on L7 of the OSI model
* ALB has Listeners, Rules and Target Groups to route traffic
* ALBs are now recommend as the default LB for VPCs. They perform better than CLBs and are most always cheaper.
* Content rules can direct certain traffic to specific target groups.
  * Host-based rules: Route traffic based on the host used
  * Path-based rules: Route traffic based on URL path
* ALBs support EC2, ECS, EKS, Lambda, HTTPS, HTTP/2 and WebSockets, and they can be integrated with AWS Web Application Firewall (WAF)
* Sticky sessions can be enabled for ALB
  
### Network Load Balancers
* NLB user Listeners and Target Groups to route traffic
* NLB is for high network throughput applications


