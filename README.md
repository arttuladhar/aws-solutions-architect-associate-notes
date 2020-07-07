# aws-solutions-architect-associate-notes

Here are some notes on various AWS services and technologies as I went through AWS Solution Architect Training.

For better readability, I have added [Hugo](https://gohugo.io/) support using Docker container.

* [01 - AWS Compute Services](01-Compute.md)
* [02 - VPC Networking](02-Networking.md)
* [03 - AWS Storage](03-Storage.md)
* [04 - Network and Content Delivery](04-Network-Content-Delivery.md)
* [05 - AWS Database Services](05-Database.md)
* [06 - Analytics](06-Analytics.md)
* [07 - Application Integration](07-Application-Integration.md)
* [08 - Hybrid and Scaling](08-Hybrid-Scaling.md)

---

### Building Site using Hugo

#### Using Docker Engine
```
docker image build -t hugo-aws-study .
docker container run --rm -it -p 8080:80 hugo-aws-study
```

#### Using Docker Compose
```
docker compose up
```

Url - [http://localhost:8080/](http://localhost:8080/)