oc new-build --name custom-sso73-openshift --binary --strategy source --image-stream redhat-sso73-openshift:1.0
oc start-build custom-sso73-openshift --from-dir . --follow





oc new-app --image-stream=custom-sso73-openshift:latest
oc expose svc/sso-custom