---
title: 02 - VPC Networking
---

## Virtual Private Cloud (VPC)

* A private network within AWS. It lets you provision a logically isolated section of AWS cloud where you can launch AWS resources in a virtual network you define.
* Can be configured to be public/private or a mixture
* Regional Service (can’t span regions), highly available, and can be connected to your data center and corporate networks
* Isolated from other VPCs by default
* VPC and subnet: Max /16 (65,536 IPs) and minimum /28 (16 IPs)
* VPC subnet cannot span AZs (1:1 Mapping)
* Certain IPs are reserved in subnets
* By default you can create up to 5 VPC per region
* Default VPC
  * Required for some AWS services
  * Pre-configured with all required network / security configurations
  * A `/20` Public subnet in each AZ, allocating a public P by default
  * Attached internet gateway with a "main" route table sending all IPv4 traffic to the internet gateway using a `0.0.0.0/0` route

---

### VPC Routing

* Every VPC has a virtual routing device called the **VPC Router**
* Router interconnects subnet and directs traffic entering and leaving the VPC and it's subnets
* **Router Table** is a collection of routes that are used when traffic from a subnet arrives at the VPC Router
* Every route table has a local route, which matches the CIDR of the VPC and lets traffic be routed between subnets
* A route contains a destination and a target. Traffic is forwarded to the target if its destination matches the route destination
* If multiple routes apply, the **most** specific is chosen. A/32 is chosen before a /24, before a /16
* A subnet is a public subnet if it is
  * (1) configured to allocate public IPs
  * (2) if the VPC has an associated internet gateway
  * (3) if that subnet has a default route to that internet gateway.

---

### Subnets

* Public Subnet - If a subnet traffic is routed to Internet Gateway, the subnet is known as a Public Subnet
* Private Subnet - If the subnet doesn't have a route to Internet Gateway, then the subnet is Private Subnet
* VPN only Subnet - If the subnet doesn't have route to Internet Gateway, but has it's traffic routed to virtual private gateway for a VPN
* Subnet map 1 on 1 to AZ's and cannot span AZ

---

## NAT Gateway

* NAT (Network Address Translation) is a process where the source or destination address of an IP packets are changed
* Static NAT is process of 1:1 translation where an internet gateway converts a private address to public IP Address
* Dynamic NAT is a variation that allows many private IP to get outgoing internet access using smaller number of public IP (generally one)
* Dynamic NAT is provided within AWS using NAT gateway that allows private subnet in AWS VPC to access the internet
* NAT Gateway is used to enable instances ina private subnet to connect to the internet or other AWS services, but prevent the internet from initiating a connection with those instances
* NAT Gateway must be crated within a Public Subnet
* NAT Gateway is not HA by design. For multi AZ redundancy, create NAT gateway in each AZ with routes for private subnet to use local gateway
* NAT instances are simply EC2 instances with specially configured routing table

---

## Internet Gateway (IGW)

* IG is horizontally scaled, redundant and highly available VPC component that allows communication between instance in your VPC and internet
* IG serves as:
  * To provide target in your VPC route table for internet routable traffic
  * To perform NAT translation for instance that have been assigned public Ipv4 address
* You cannot have multiple IG for a single VPC

---

## VPC Endpoint

* VPC Endpoints are gateway objects created within a VPC. They can be used to connect to AWS public servers without the need for the VPC to have an attached internet gateway and be public.
* VPC Endpoint Types:
  * Gateway endpoints: Can be used for DynamoDB and S3
  * Interface endpoints: Can be used for everything else (e.g. SNS, SQS)
* Gateway endpoints are free whereas Interface endpoint cost money
* Gateway endpoints are HA across AZs in a region
* Interface endpoint uses and Elastic Network Interface (ENI) with private IP
* Interface endpoints are interfaces in a specific subnet. For HA, you need to add multiple interfaces - one per AZ

---

## Security Group (SG)

* Security group acts like a firewall at the instance level
* Unless allowed specifically, all inbound traffic is blocked by default
* All outbound traffic from the instance is allowed by default
* SGs are Stateful, which means if traffic is allowed inbound it is also allowed outbound
* EC2 instances can belong to multiple SG
* Using SG, you cannot block specific IP, SG only supports allow
* You can have up to 10,000 SG per region
* You can have 60 inbound and 60 outbound rules per Security Group
* You can have 16 SG associated to an ENI

---

## Network Access Control List (NACL)

* NACLs are collection of rules that explicitly allow or deny traffic based on its protocol, port range, and source/destination (Unlike SG, which can only allow)
* NACL operate at Layer 4 of the OSI Model (TCP/UDP and below)
* Each subnet within a VPC must be associated with a NACL
* NACLs only impact traffic crossing the boundary of a subnet. (If communication occurs within a subnet, no NACLs are involved)
* Rules are processed in number order, lowest first. When a match is found, that action is taken and processing stops
* NACLs are stateless
* NACL can be used to block a single IP (SG cannot perform implicitly deny)

---

## AWS Managed VPN

* Virtual Private Network (VPN) provides a software based secure connection between a VPC and On-premise networks
* Components of VPN
  * Customer Gateway (CGW) - Configuration for On-Premise Router
  * Virtual Private Gateway attached to VPC
  * VPN Connection

---

## VPC Peering

* Allows direct communication between VPCs enabling you to route traffic privately using private IPv4 address or IPv6 address
* Services can communicate using private IPs from VPC to VPC
* VPC peers can span AWS accounts and even regions (with some limitations)
* Data is encrypted and transits via the AWS global backbone
* VPC peers are used to link two VPCs at layer 3
* Ideal use cases for VPC peering - company mergers, shared services, company and vendor, auditing
* During VPC peering, VPC CIDR blocks cannot overlap
* Routing across VPC is not transitive
* NACL and SGs can be used to control access on the VPC peering
