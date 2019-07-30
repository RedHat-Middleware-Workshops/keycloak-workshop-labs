== Vertx Kubernetes Workshop image:https://api.travis-ci.org/jbossdemocentral/vertx-kubernetes-workshop-infra.svg?branch=ocp-3.11[Build Status,link=https://travis-ci.org/jbossdemocentral/vertx-kubernetes-workshop-infra]

This is a 3 hours hands-on reactive programming workshop with Vert.x, explaining how to build distributed microservice reactive applications using Eclipse Vert.x and deploy them on Openshift

Complete code is available in the solution directory.

== Agenda

* Prerequisites
* Introduction to Vert.x
* Demystifying microservices
* First step with Openshift
* Building Reactive Services with Vert.x
* The Micro-Trader Application
* The first microservice - the quote generator
* Event bus services - Portfolio service 
* The compulsive traders 
* The Audit service
* Resilience, Circuit Breaker and API Proxy - the currency service


== Install Workshop Infrastructure

An APB [https://quay.io/repository/openshiftlabs/vertx-workshop-apb] is provided for 
deploying the Workshop infra (lab instructions, CodeReady Workspaces, etc) in a project 
on an OpenShift cluster via the service catalog. In order to add this APB to the OpenShift service catalog, log in 
as cluster admin and perform the following in the `*openshift-ansible-service-broker*` project :

1. Edit the `*broker-config*` configmap and add this snippet right after `*registry*`:

[source,yaml]
----
    - name: dh
      type: quay.io
      org: openshiftapb
      tag: ocp-3.11
      white_list: [.*-apb$]
----

2. Redeploy the `*asb*` deployment

You can https://docs.openshift.com/container-platform/3.11/install_config/oab_broker_configuration.html#oab-config-registry-dockerhub[read more in the docs^] 
on how to configure the service catalog.

As an alternative, you can also run the APB directly in a pod on OpenShift to install the workshop infra:

[source,shell]
----
oc login
oc new-project lab-infra
oc run apb --restart=Never --image="quay.io/openshiftlabs/vertx-workshop-apb:ocp-3.11" \
    -- provision -vvv -e namespace=$(oc project -q) -e openshift_token=$(oc whoami -t)
----

Or if you have Ansible installed locally, you can also run the Ansilbe playbooks directly on your machine:

[source,shell]
----
oc login
oc new-project lab-infra

ansible-playbook -vvv playbooks/provision.yml \
       -e namespace=$(oc project -q) \
       -e openshift_token=$(oc whoami -t) \
       -e openshift_master_url=$(oc whoami --show-server)
---- 

== Lab Instructions on OpenShift

TIP: If you have used the above workshop installer, the lab instructions are already deployed.

[source,shell]
----
oc new-app quay.io/osevg/workshopper:latest --name=guides \
    -p LOG_TO_STDOUT=true \
    -p WORKSHOPS_URLS="https://raw.githubusercontent.com/jbossdemocentral/vertx-kubernetes-workshop-infra/ocp-3.11/_workshop-guides-che.yml"
oc expose svc/guides
----

== Local Lab Instructions

[source,shell]
----
docker run -it --rm -p 8080:8080 \
      -v $(pwd):/app-data \
      -e LOG_TO_STDOUT=true \
      -e CONTENT_URL_PREFIX="file:///app-data" \
      -e WORKSHOPS_URLS="file:///app-data/_workshop-guides-che.yml" \
      quay.io/osevg/workshopper:latest
----
