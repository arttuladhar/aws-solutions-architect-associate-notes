* [01 - AWS Compute Services](01-Compute.md)
* [02 - VPC Networking](02-Networking.md)
* [03 - AWS Storage](03-Storage.md)
* [04 - Network and Content Delivery](04-Network-Content-Delivery.md)
* [05 - AWS Database Services](05-Database.md)
* [06 - Analytics](06-Analytics.md)
* [07 - Application Integration](07-Application-Integration.md)
* [08 - Hybrid and Scaling](08-Hybrid-Scaling.md)

---

```
# Using Docker Engine
docker image build -t hugo-aws-study .
docker container run --rm -it -p 8080:80 hugo-aws-study

# Using Docker Compose
docker compose up
```