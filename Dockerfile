FROM registry.access.redhat.com/redhat-sso-7/sso73-openshift

COPY magic-link/target/magic-link.jar /deployments/
RUN touch /deployments/magic-link.jar.dodeploy

COPY themes/target/themes.jar /deployments/
RUN touch /deployments/themes.jar.dodeploy

COPY token-validation/target/token-validation.jar /deployments/
RUN touch /deployments/token-validation.jar.dodeploy