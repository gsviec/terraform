### Deploy kubernetes via Terrafrom

Before deploy kubernets we need few parameters such as KOPS_STATE_STORE, NAME, ZONE, etc.

```
export NAME=dev.phanbook.com
export KOPS_STATE_STORE=s3://kubernetes-dev-phanbook.com
export ZONES="eu-central-1a,eu-central-1b,eu-central-1c"
export MASTER_ZONE="eu-central-1a,eu-central-1b,eu-central-1c"
export VPC_ID=$(terraform output vpc_id)
export CLUSTER_MASTER_SIZE="t2.nano"
export CLUSTER_NODE_SIZE="t2.nano"
export K8S_VERSION="1.9.6"
export CLUSTER_NODE_COUNT="3"
export CLUSTER_MASTER_COUNT="3"
export AWS_KEYPAIR_PUB_KEY_PATH="~/.ssh/id_rsa.pub"

```

If you do not want add manual it, we have add helper into run.sh file

```
./run.sh prepare

```


To deploy it just doing the command below:

```
terraform plan
terraform apply

```

Then you need waiting a moment after that go to hosted zones to check record have add success or not [at](https://console.aws.amazon.com/route53/home?region=eu-central-1#hosted-zones:)

If not, you need running kops helper to deploy it

```
kops cluster update $NAME --yes

````



### Destroy kubernetes via Terraform

Becuase sometime we need keep s3 store version deploy kubernetes to deploy agian so that to destroy it we need running follwing command below:

```
./run.sh destroy

```
