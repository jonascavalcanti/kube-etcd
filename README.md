# ETCD Server v2.3.8

<img src="https://jujucharms.com/_icon/120/etcd.png" width="100">

----

etcd is a distributed key value store that provides a reliable way to store data across a cluster of machines. 
It’s open-source and available on GitHub. etcd gracefully handles leader elections during network partitions and will tolerate machine failure, including the leader.
Your applications can read and write data into etcd. A simple use-case is to store database connection details or feature flags in etcd as key value pairs. These values can be watched, allowing your app to reconfigure itself when they change.
Advanced uses take advantage of the consistency guarantees to implement database leader elections or do distributed locking across a cluster of workers.

----

# Environment Variables Defaults

The etcd server image uses several environment variables which are easy to miss. 
While none of the variables are required, they may significantly aid you in using the image.

```
KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
PATH_ETCD="/opt/etcd"
ETCD_PREFIX="/cluster.local/network"
PATH_ETCD_DATA="${PATH_ETCD}/data"
FILE_ETCD_BD_NAME="bd.etcd"

```

# How to use this image

Start with docker command

```
docker run -d  \
    --name <container_name> \ 
    -p 2379:2379 -p 2380:2380 \
    -e KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16" \
    -e PATH_ETCD="/opt/kubernetes/etcd" \
    -e ETCD_PREFIX="/cluster.local/network" \
    -e PATH_ETCD_DATA="${PATH_ETCD}/data" \
    -e FILE_ETCD_BD_NAME="bd.etcd" \
    -v /<path_local>/etcd:/<path_container/etcd/data \
     <image>:<tag>

```

# Docker example

```
docker run -d --name etcd -h etcd -p 2379:2379 -p 2380:2380 -e ETCD_PREFIX="/company.br/network" -v /opt/kubernetes/etcd:/opt/etcd/data etcd

```

