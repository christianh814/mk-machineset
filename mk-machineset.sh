#!/bin/bash
rm -rf ./out
###
# For vSphere, just leave dummy values for region/zones/ami

# Output of: oc get -o jsonpath='{.status.infrastructureName}' infrastructure cluster 
clusterid="cluster2-79bxd"
# AWS Region and zone 
region="us-east-1"
zones=(us-east-1a us-east-1b us-east-1c)
# AMI of RHCOS
ami="ami-00e472e63fc0dbe01"
###
mkdir -p ./out/
if [[ ${1} == "vsphere" ]] ; then
	echo -n "Creating MachineSet manifests (vSphere)..."
	templatefile=./templates/99_openshift-cluster-api_infra-machineset-TEMPLATE-vmw.yaml
	[[ ! -e ${templatefile} ]] && echo "FATAL: ${templatefile} not found" && exit
	export CLUSTERID=${clusterid}
	envsubst < ${templatefile} > ./out/99_openshift-cluster-api_infra-machineset-0.yaml
	echo "DONE, manifests should be under ./out - Make sure to change instance size if you don't want 4x16"
else
	templatefile=./templates/99_openshift-cluster-api_infra-machineset-TEMPLATE.yaml
	[[ ! -e ${templatefile} ]] && echo "FATAL: ${templatefile} not found" && exit
	echo -n "Creating MachineSet manifests (AWS)..."
	for zone in ${!zones[*]}
	do
		export CLUSTERID=${clusterid}
		export REGION=${region}
		export ZONE=${zones[${zone}]}
		export AMI=${ami}
		envsubst < ${templatefile} > ./out/99_openshift-cluster-api_infra-machineset-${zone}.yaml
	done
	echo "DONE, manifests should be under ./out - Make sure to change the instance type if you don't want m4.2xlarge"
fi
###
##
##
