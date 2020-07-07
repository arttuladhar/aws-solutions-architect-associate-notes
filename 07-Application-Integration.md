---
title: 07 - Application Integration
---

## Amazon Simple Notification Service (SNS)

* SNS is a fully managed pub/sub messaging service
* Topics are logical access point and communication channel within SNS
* Topics can be encrypted via KMS
* Subscribers are endpoints that receive message for topic. When a topic received a message it automatically and immediately pushes messages to subscribers
* SNS supports notification over multiple protocols:
  * HTTP/HTTPS - Subscribers specify a URL as part of the subscription registration
  * Email/Email Json - Messages are sent to registered address as email
  * SQS - User can specify an SQS standard queue as the endpoint
  * SMS - Messages are sent to registered phone number as SMS text messages

## Amazon Simple Queue Service (SQS)

* SQS provides fully managed, highly available message queuing service for inter-process /service /service messaging
* SQS is used for application integration, it lets decouple different systems
* SQS supports both Standard and FIFO Queues
* Standard queues are distributed and scalable to nearly unlimited message volume. The order is not guaranteed, best-effort only, and messages are guaranteed to be delivered at least once but sometimes more than once.
* FIFO queues ensure first-in,first-out delivery. Messages are delivered once only - duplicates do not occur. The throughput is limited to ~ 3,000 messages per second with batching or ~300 without by default.
* There are two types of polling
  * **Short Polling** - Available messages are returned immediately, even if the message queue being polled is empty
  * **Long Polling** - Waits for message for a given WaitTimeSeconds (More Efficient)
* Each SQS message can contain up to 256KB of data but can link data stored in S3 for any larger payloads
* Visibility time-out is the period of time that messages are invisible in the SQS queue
* Messages will be deleted from queue after a job has processed
* When a message is polled, it is hidden in the queue. It can be deleted when processing is completed - otherwise, after a VisibilityTimeout period, it will return to the queue
* The default Visibility time-out is 30 seconds. Timeout can be 0 seconds to a maximum of 12 hours.
* Retention period of SQS can be from 60 seconds to 14 days (Default is 4 Days)
* Message size is between 1 byte to 256 kB, Extended Client Library for Java can increase to 2 GB

## AWS Step Functions

* Step Functions are Serverless visual workflow service that provides state machines
* A state machine can orchestrate other AWS services with simple logic, branching, and parallel execution, and it maintains a state
* Workflow steps are known as **states**, and they can perform work via **tasks**
* State machines maintain state and allow longer running processes.

