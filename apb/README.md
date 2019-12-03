# Setting up a the SSO Kubernetes Worskhop 

If running via your own machine you can run the following command

  ```
  oc new-project labs-infra

  oc run apb --restart=Never --image="quay.io/sshaaf/sso-kubernetes-workshop-apb" \
             --image-pull-policy="Always" \
             -- provision -vvv \
             -e namespace="$(oc project -q)"  \
             -e openshift_token=$(oc whoami -t) \
             -e openshift_master_url=$(oc whoami --show-server)/console
  ```

to follow the logs
  ```
  oc logs apb -f
  ```
docker run -it --rm -p 8080:8080 -v $(pwd):/app-data \
              -e CONTENT_URL_PREFIX="file:///app-data" \
              -e WORKSHOPS_URLS="file:///app-data/_workshop.yml" \
              -e LOG_TO_STDOUT=true  \
              quay.io/osevg/workshopper