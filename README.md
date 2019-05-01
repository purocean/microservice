Microservice Sample
==============

## 运行
1. 安装 docker docker-compose
1. 构建镜像 `sh scripts/createdemo.sh`
1. 运行微服务 `cd docker; dokcer-compose up`

## 访问
1. 入口：http://ip:8081

## 说明
1. 业务逻辑：顾客管理/产品管理/订单下单管理
1. 顾客服务：Customer List / add / remove customers
1. 产品服务：Catalog List / add / remove items
1. 产品搜索服务：Catalog Search Items
1. 订单服务：Order Create an order
1. 注册中心管理（不适用）：Eureka (Vagrant) Service discovery
1. 注册中心管理：Eureka (Docker Compose / Docker Machine) Service discovery
1. 负载均衡管理（不适用） Hystrix dashboard (Vagrant) Monitor state of Hystrix
1. 负载均衡管理Hystrix dashboard (Docker Compose / Docker Machine) Monitor state of Hystrix


------------------------------------------------------------------------------------------------------------------

[German / Deutsch](LIESMICH.md)

This is a sample for my
Microservices Book ([English](http://microservices-book.com/) / [German](http://microservices-buch.de/)) .

This project creates a VM with the complete micro service demo system
in Docker containers inside a Vagrant VM. The services are implemented
in Java using Spring and Spring Cloud.

It uses three microservices:
- Order to process orders.
- Customer to handle customer data.
- Catalog to handle the items in the catalog.

Technologies
------------

- Eureka for Lookup
- Ribbon for Load Balancing. See the classes CatalogClient and
  CustomerClient in com.ewolff.microservice.order.clients in the
  microservice-demo-order project.
- Hystrix is used for resilience. See CatalogClient in
  com.ewolff.microservice.order.clients in the microservice-demo-order
  project . Note that the CustomerClient won't use Hystrix. This way
  you can see how a crash of the Customer microservices makes the
  Order microservice useless.
- Hystrix has a dashboard. Turbine can be used to combine the data
from multiple sources. However, this does not work at the moment.
- Zuul is used to route HTTP requests from the outside to the
  different services.
- Spring Cloud Config isn't used. It is disabled with
  spring.cloud.config.enabled=false in the bootstrap files.


How To Run
----------

The demo can be run with [Vagrant](docker-vagrant/README.md) or [Docker Machine and Docker
Compose](docker/README.md).

[How to run](HOW-TO-RUN.md) includes more details.


Remarks on the Code
-------------------

The servers for the infrastruture are pretty simple thanks to Spring Cloud:

- microservice-demo-eureka is the Eureka server for service discovery.
- microservice-demo-zuul is the Zuul server. It distributes the requests to the three microservices.
- microservice-demo-turbine can be used to consolidate the Hystrix metrics and has a Hystrix dashboard.

The microservices are:
- microservice-demo-catalog is the application to take care of items.
- microserivce-demo-customer is responsible for customers.
- microservice-demo-order does order processing. It uses microservice-demo-catalog and microservice-demo-customer. Ribbon is used for load balancing and Hystrix for resilience.


The microservices have an Java main application in src/test/java to run them stand alone. microservice-demo-order uses a stub for the other services then. Also there are tests that use customer driven contracts. That is why it is ensured that the services provide the correct interface. These CDC tests are used in microservice-demo-order to verify the stubs. In microserivce-demo-customer and microserivce-demo-catalog they are used to verify the implemented REST services.
