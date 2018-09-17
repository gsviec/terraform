### Manual setup after deploy terraform

Waiting aws launch load balancer and ec2 then login to node-1 and init mongodb replication with following command below:


```
 rs.initiate()
 rs.add("mongodb-02.staging.urbn8.io")
 rs.add("mongodb-03.staging.urbn8.io")
 rs.conf()
 rs.status()

```
