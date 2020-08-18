# Create Infra Node Machine Sets

Quick and Dirty shell script to create machinesets

## Setup 

Edit this script with your variables, for example.

```shell
clusterid="cluster2-79bxd"
region="us-east-1"
zones=(us-east-1a us-east-1b us-east-1c)
ami="ami-00e472e63fc0dbe01"
```

* `clusterid` is the output of `oc get -o jsonpath='{.status.infrastructureName}' infrastructure cluster`
* `region` is the AWS region your cluster is in
* `zones` is an array of the AWS zones you want your infra node to be in.
* `ami` is the name of the AWS ami of RHCOS

> :rotating_light: For vSphere, just leave dummy values for `region`, `zones`, and `ami`


## Run

Run the script for AWS

```shell
./mk-machineset.sh
```

Run the script for vSphere

```shell
./mk-machineset.sh vsphere
```

## SLA

I make no guarantees for this QnD script, so YMMV. Use caution.
