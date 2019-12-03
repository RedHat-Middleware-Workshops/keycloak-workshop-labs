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
