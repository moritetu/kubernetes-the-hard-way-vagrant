#!/bin/bash

readonly dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${dir}/versions.sh"

sudo apt-get update
sudo apt-get -y install socat conntrack ipset

wget -q --show-progress --https-only --timestamping \
  https://github.com/kubernetes-incubator/cri-tools/releases/download/${crictl_version}/crictl-${crictl_version}-linux-amd64.tgz \
  https://storage.googleapis.com/kubernetes-the-hard-way/runsc \
  https://github.com/opencontainers/runc/releases/download/${runc_version}/runc.amd64 \
  https://github.com/containernetworking/plugins/releases/download/${cni_plugins_version}/cni-plugins-linux-amd64-${cni_plugins_version}.tgz \
  https://github.com/containerd/containerd/releases/download/${containerd_version}/containerd-${containerd_version#v}-linux-amd64.tar.gz \
  https://storage.googleapis.com/kubernetes-release/release/${k8s_version}/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/${k8s_version}/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/${k8s_version}/bin/linux/amd64/kubelet

sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes

chmod +x kubectl kube-proxy kubelet runc.amd64 runsc
sudo mv runc.amd64 runc
sudo mv kubectl kube-proxy kubelet runc runsc /usr/local/bin/
sudo tar -xvf crictl-${crictl_version}-linux-amd64.tar.gz -C /usr/local/bin/
sudo tar -xvf cni-plugins-linux-amd64-${cni_plugins_version}.tgz -C /opt/cni/bin/
sudo tar -xvf containerd-${containerd_version#v}-linux-amd64.tar.gz -C /
