#!/bin/bash

curl -O -L https://storage.googleapis.com/kubernetes-the-hard-way/coredns.yaml
kubectl apply -f coredns.yaml

cat >coredns-corefile.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors
        health
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
          pods insecure
          fallthrough in-addr.arpa ip6.arpa
        }
        prometheus :9153
        forward . 8.8.8.8
        cache 30
        loop
        reload
        loadbalance
    }
EOF
kubectl apply -f coredns-corefile.yaml

#kubectl create -f https://raw.githubusercontent.com/kelseyhightower/kubernetes-the-hard-way/1.18.6/deployments/kube-dns.yaml

watch kubectl get pods -l k8s-app=kube-dns -n kube-system -o wide
