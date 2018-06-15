#!/bin/bash

/usr/bin/etcd \
    --name=master \
    --data-dir=${PATH_ETCD_DATA}/${FILE_ETCD_BD_NAME} \
    --listen-client-urls=http://0.0.0.0:2379 \
    --advertise-client-urls=http://0.0.0.0:2379

