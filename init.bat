@echo off
set BASE_URL=https://start.spring.io/starter.zip
set BOOT_VERSION=3.3.4
set JAVA_VERSION=17

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=config-server&groupId=com.rikkeibank&artifactId=config-server&name=config-server&description=config-server&packageName=com.rikkeibank.configserver&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=cloud-config-server,actuator" -o config-server.zip
tar -xf config-server.zip
del config-server.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=discovery-server&groupId=com.rikkeibank&artifactId=discovery-server&name=discovery-server&description=discovery-server&packageName=com.rikkeibank.discoveryserver&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=cloud-eureka-server,actuator" -o discovery-server.zip
tar -xf discovery-server.zip
del discovery-server.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=api-gateway&groupId=com.rikkeibank&artifactId=api-gateway&name=api-gateway&description=api-gateway&packageName=com.rikkeibank.apigateway&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=cloud-gateway,cloud-eureka,actuator,cloud-resilience4j,webflux" -o api-gateway.zip
tar -xf api-gateway.zip
del api-gateway.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=identity-service&groupId=com.rikkeibank&artifactId=identity-service&name=identity-service&description=identity-service&packageName=com.rikkeibank.identityservice&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=web,data-jpa,h2,cloud-eureka,actuator,cloud-config-client,security,lombok" -o identity-service.zip
tar -xf identity-service.zip
del identity-service.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=customer-service&groupId=com.rikkeibank&artifactId=customer-service&name=customer-service&description=customer-service&packageName=com.rikkeibank.customerservice&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=web,data-jpa,h2,cloud-eureka,actuator,cloud-config-client,lombok" -o customer-service.zip
tar -xf customer-service.zip
del customer-service.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=account-service&groupId=com.rikkeibank&artifactId=account-service&name=account-service&description=account-service&packageName=com.rikkeibank.accountservice&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=web,data-jpa,h2,cloud-eureka,actuator,cloud-config-client,lombok,data-redis" -o account-service.zip
tar -xf account-service.zip
del account-service.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=transaction-service&groupId=com.rikkeibank&artifactId=transaction-service&name=transaction-service&description=transaction-service&packageName=com.rikkeibank.transactionservice&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=web,data-jpa,h2,cloud-eureka,actuator,cloud-config-client,cloud-resilience4j,kafka,lombok" -o transaction-service.zip
tar -xf transaction-service.zip
del transaction-service.zip

curl -sL "%BASE_URL%?type=maven-project&language=java&bootVersion=%BOOT_VERSION%&baseDir=notification-service&groupId=com.rikkeibank&artifactId=notification-service&name=notification-service&description=notification-service&packageName=com.rikkeibank.notificationservice&packaging=jar&javaVersion=%JAVA_VERSION%&dependencies=webflux,cloud-eureka,actuator,cloud-config-client,kafka,lombok" -o notification-service.zip
tar -xf notification-service.zip
del notification-service.zip

echo All services downloaded.
