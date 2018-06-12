FROM centos:7.4.1708
LABEL MAINTAINER="unisp <cicero.gadelha@funceme.br | jonas.cavalcantineto@funceme.com>"

RUN yum update -y
RUN yum install -y \
            vim \
            wget \
            epel-release.noarch \
            openssl 

RUN yum update -y
RUN yum install -y supervisor.noarch                 

#ETCD
ENV KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
ENV PATH_ETCD="/opt/etcd"
ENV ETCD_PREFIX="/cluster.local/network"
ENV PATH_ETCD_DATA="${PATH_ETCD}/data"
ENV FILE_ETCD_BD_NAME="bd.etcd"
ENV ETCD_VER="v2.3.8"

#ENV ETCDCTL_API "3" 

RUN set -ex \
        && mkdir -p ${PATH_ETCD_DATA} \
        && curl -L  https://github.com/coreos/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o ${PATH_ETCD}/etcd-${ETCD_VER}-linux-amd64.tar.gz && tar xzvf ${PATH_ETCD}/etcd-${ETCD_VER}-linux-amd64.tar.gz -C ${PATH_ETCD} \
        && cp -a ${PATH_ETCD}/etcd-${ETCD_VER}-linux-amd64/etcd /usr/bin \
        && cp -a ${PATH_ETCD}/etcd-${ETCD_VER}-linux-amd64/etcdctl /usr/bin \
        && rm -rf ${PATH_ETCD}/etcd-${ETCD_VER}-linux-amd64.tar.gz
 
EXPOSE 2379 2380

COPY conf/supervisord.conf /etc/

ADD bin/create_etcd_prefix.sh /create_etcd_prefix.sh
ADD bin/start_etcd.sh /start_etcd.sh
ADD bin/start.sh /start.sh

RUN chmod +x /create_etcd_prefix.sh
RUN chmod +x /start.sh
RUN chmod +x /start_etcd.sh
CMD ["./start.sh"]
