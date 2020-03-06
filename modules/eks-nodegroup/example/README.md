To create a Cluster Autoscaler deployment, run the following command:

```
kubectl apply -f cluster-autoscaler-autodiscover.yaml

```

To check the Cluster Autoscaler deployment logs for deployment errors, run the following command:

```
kubectl logs -f deployment/cluster-autoscaler -n kube-system

```

## Horizontal Pod Autoscaler

https://docs.aws.amazon.com/eks/latest/userguide/horizontal-pod-autoscaler.html

```
kubectl apply -f metrics-server/deploy/1.8+/

```

Verify that the metrics-server deployment is running the desired number of pods with the following command. 

```
kubectl get deployment metrics-server -n kube-system

```

## Test the scale out of the EKS worker nodes

- To see the current number of worker nodes, run the following command:

kubectl get nodes

- To increase the number of worker nodes, run the following commands:

```
kubectl create deployment autoscaler-demo --image=nginx
kubectl scale deployment autoscaler-demo --replicas=10
```

```
kubectl get nodes
kubectl get deployment autoscaler-demo --watch
```

## Authen


aws sts get-caller-identity




