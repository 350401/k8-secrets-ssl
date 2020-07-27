#!/bin/bash

echo " Maven Build"
mvn clean install

sleep 5
clear
printf " \n\n\n****************** Build Spring boot app docker image *******************\n"
docker build -t pavanrankireddy/k8ssl:latest .

#docker push pavanrankireddy/k8ssl:latest


#Copy your certificate to somewhere kubectl is configured for this Kubernetes cluster.
# We will call the file /baeldung.p12 and copy it to the /opt/certs folder.
kubectl create secret generic ssl-keystore --from-file=./src/main/resources/certs
kubectl create secret generic ssl-secret --from-literal=keypass='changeit'

#kubectl get secrets
#kubectl describe secrets/ssl-secret

sleep 5

printf " \n *************** Cleanup Existing Deployments ********************* \n\n"
kubectl delete deployment springboot-service-1

sleep 5

printf "\n\n  ******************** Starting Service Mesh Deployments ******************* \n "
 kubectl apply -f service1-deployment.yml
printf " \n ******************** Finished Service Mesh Deployments *******************"

sleep 5

