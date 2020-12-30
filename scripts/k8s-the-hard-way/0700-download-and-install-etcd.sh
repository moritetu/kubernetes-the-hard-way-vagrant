#!/bin/bash

readonly dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${dir}/versions.sh"

wget -q --show-progress --https-only --timestamping \
  "https://github.com/coreos/etcd/releases/download/${etcd_version}/etcd-${etcd_version}-linux-amd64.tar.gz"

tar -xvf etcd-${etcd_version}-linux-amd64.tar.gz
sudo mv etcd-${etcd_version}-linux-amd64/etcd* /usr/local/bin/
