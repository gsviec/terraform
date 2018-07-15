#!/bin/bash
set -eo pipefail

if [[ $1 == 'prepare' ]]; then
	if [[ ! -d ".terraform" ]]; then
		echo "You need create s3 bucket to store state kops firstly. To do it running the command ./run.sh s3"
		exit;
	fi
	export KOPS_STATE_STORE=$(terraform output state_store)
	export ZONES="eu-central-1a,eu-central-1b,eu-central-1c"
	export MASTER_ZONE="eu-central-1a,eu-central-1b,eu-central-1c"
	export CLUSTER_MASTER_SIZE="t2.micro"
	export CLUSTER_NODE_SIZE="t2.medium"
	export K8S_VERSION="1.9.6"
	export CLUSTER_NODE_COUNT="3"
	export CLUSTER_MASTER_COUNT="3"
	export AWS_KEYPAIR_PUB_KEY_PATH="~/.ssh/id_rsa.pub"

	export NAME=$(terraform output cluster_name)
	cd ../vpc
	export VPC_ID=$(terraform output vpc_id)
	cd -

fi

if [[ $1 == 'deploy' ]]; then
	MESSAGE="Build kubenetes with command: 
    kops create --master-zones=$MASTER_ZONE
    --zones=$ZONES
    --dns-zone=${NAME}
    --vpc=${VPC_ID}
    --master-size=${CLUSTER_MASTER_SIZE}
    --node-size=${CLUSTER_NODE_SIZE}
    --node-count=${CLUSTER_NODE_COUNT}
    --master-count=${CLUSTER_MASTER_COUNT}
    --ssh-public-key=${AWS_KEYPAIR_PUB_KEY_PATH}
    --kubernetes-version=${K8S_VERSION}
    --cloud=aws
    --topology=private
    --networking=flannel-vxlan
    --name=${NAME}
    "
	curl -s 'http://consul.staging.rcapp.co:8500/v1/kv/terraform/slack?dc=staging&raw=true' | bash -s "$MESSAGE"
	echo "$MESSAGE"

	kops create cluster \
	    --master-zones=$MASTER_ZONE \
	    --zones=$ZONES \
	    --dns-zone=${NAME} \
	    --vpc=${VPC_ID} \
	    --master-size=${CLUSTER_MASTER_SIZE} \
	    --node-size=${CLUSTER_NODE_SIZE} \
	    --node-count=${CLUSTER_NODE_COUNT} \
	    --master-count=${CLUSTER_MASTER_COUNT} \
	    --ssh-public-key=${AWS_KEYPAIR_PUB_KEY_PATH} \
	    --kubernetes-version=${K8S_VERSION} \
	    --cloud=aws \
	    --topology=private \
	    --networking=flannel-vxlan \
	    --out=. \
  	    --target=terraform \
  	    --name=${NAME}

fi

if [[ $1 == 'dashboard' ]]; then
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.8.3.yaml
	kubectl apply -f rbac.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/grafana.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
fi
