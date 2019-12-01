Running on Openshift

oc new-build --name js-console --binary --strategy source --image-stream httpd
oc start-build js-console --from-dir . --follow
oc new-app --image-stream=js-console:latest
oc expose svc/js-console


Make sure Less Secure apps is enabled and then go on the following url to enable your account access. 
https://accounts.google.com/b/0/DisplayUnlockCaptcha



```
oc create -f is.yaml
```

Output: 
```
Name:                   js-console
Namespace:              test
Created:                16 seconds ago
Labels:                 <none>
Annotations:            openshift.io/image.dockerRepositoryCheck=2019-11-29T07:51:16Z
                        openshift.io/image.insecureRepository=true
Image Repository:       docker-registry.default.svc:5000/test/js-console
Image Lookup:           local=true
Unique Images:          1
Tags:                   1

latest
  tagged from quay.io/sshaaf/js-console:latest
    will use insecure HTTPS or HTTP connections

  * quay.io/sshaaf/js-console@sha256:a2ce07bf5ecd2756c70135652f2bc98702550635250bb2faee8dbec7937e100b
      16 seconds ago
```