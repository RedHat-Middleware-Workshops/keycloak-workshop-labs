Running on Openshift

oc new-build --name js-console --binary --strategy source --image-stream httpd
oc start-build js-console --from-dir . --follow
oc new-app --image-stream=js-console:latest
oc expose svc/js-console

