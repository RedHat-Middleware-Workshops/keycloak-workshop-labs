[![CircleCI](https://circleci.com/gh/snowdrop/secured-example.svg?style=shield)](https://circleci.com/gh/snowdrop/secured-example)

# How to play with the SSO Example locally

NOTE: `service.sso.yaml` and `.openshiftio/service.sso.yaml` must be always kept in sync.

- Deploy Keycloak on Openshift
```
oc new-project sso
oc create -f service.sso.yaml
```

- Get Keycloak Auth Endpoint
```
SSO_URL=$(oc get route secure-sso -o jsonpath='https://{.spec.host}/auth')
```

- Start Spring Boot using Keycloak Auth address
```
mvn spring-boot:run -DSSO_AUTH_SERVER_URL=${SSO_URL}
```

- Use curl to access the endpoint without authentication
```
curl http://localhost:8080/api/greeting
{"timestamp":1508772409753,"status":401,"error":"Unauthorized","message":"No message available","path":"/api/greeting"}
```

- Open the home page within your browser `http://localhost:8080/index.html`, log on to Keycloak using `alice` as user and `password` as password and grab the curl request + token
```
curl -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJRek1nbXhZMUhrQnpxTnR0SnkwMm5jNTNtMGNiWDQxV1hNSTU1MFo4MGVBIn0.eyJqdGkiOiJjOGMyYzM5ZC02YTAxLTQ2ZjgtODA0NC0yN2ZjMTM2Yzc5NmQiLCJleHAiOjE1MDg3NzMwNjIsIm5iZiI6MCwiaWF0IjoxNTA4NzcyNDYyLCJpc3MiOiJodHRwczovL3NlY3VyZS1zc28tc3NvLjE5Mi4xNjguNjQuNS5uaXAuaW8vYXV0aC9yZWFsbXMvbWFzdGVyIiwiYXVkIjoiZGVtb2FwcCIsInN1YiI6ImMwMTc1Y2NiLTA4OTItNGIzMS04MjlmLWRkYTg3MzgxNWZlOCIsInR5cCI6IkJlYXJlciIsImF6cCI6ImRlbW9hcHAiLCJub25jZSI6IjFiMGUwZWM0LWE3OGQtNDdkMC04YzM4LWNmNzU5NGMwMGRhMCIsImF1dGhfdGltZSI6MTUwODc3MjQ2MSwic2Vzc2lvbl9zdGF0ZSI6IjE3OGQ5NDI0LTEyZGQtNGQzYS1hMWMyLTM2MWM5M2IzYjVjYyIsImFjciI6IjEiLCJjbGllbnRfc2Vzc2lvbiI6ImM3NjlmNmJhLWE0NTEtNDk2NS1iNzIxLWNmMmMwZDJiOGVkMiIsImFsbG93ZWQtb3JpZ2lucyI6WyIqIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJib29zdGVyLWFkbWluIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsic2VjdXJlZC1ib29zdGVyLWVuZHBvaW50Ijp7InJvbGVzIjpbImJvb3N0ZXItYWRtaW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LXByb2ZpbGUiXX19LCJuYW1lIjoiQWxpY2UgSW5DaGFpbnMiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhbGljZSIsImdpdmVuX25hbWUiOiJBbGljZSIsImZhbWlseV9uYW1lIjoiSW5DaGFpbnMiLCJlbWFpbCI6ImFsaWNlQGtleWNsb2FrLm9yZyJ9.aKXU8uDFyFEbsPxG_z11QPebuECzcapBZHjsi473BZ8sETuHn07V-7lRQOrPW0t5Ds3RBi1yKPGKwgUR7LbwzzlpAQd7bmvDGWMWt6pMoJacWDUjvmb5L9pjixNytx5CzMoeybtD0Xi2qyMARjKpQClxw45mGm0gra_F4PmrxjN8eWd2dMHDhxHzLqmE0-U7hm5gPIbpm4n2uEU899xADbvWLM7KIo9eYmrAjAAZusjNK6kixUUvrcqxB9_KhhNJVMUJyvWBmDYLElN5d-o3vwsnXOU79QOw82oTnotV7kRNspYnbjYAs7whJb3y6XMQXqII46JU4I9mNb0zLz9qZw" http://localhost:8080/api/greeting
{"id":2,"content":"Hello, World!"}
```




https://appdev.openshift.io/docs/spring-boot-runtime.html#mission-secured-spring-boot
