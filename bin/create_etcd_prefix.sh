#!/bin/bash

/usr/bin/etcdctl mkdir ${ETCD_PREFIX}
/usr/bin/etcdctl mk ${ETCD_PREFIX}/config \
            "{ \"Network\": \"${KUBERNETES_CLUSTER_RANGE_IP}\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"