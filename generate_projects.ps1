$services = @(
    @{ Name = "config-server"; Dependencies = @("spring-cloud-config-server", "spring-boot-starter-actuator") },
    @{ Name = "discovery-server"; Dependencies = @("spring-cloud-starter-netflix-eureka-server", "spring-boot-starter-actuator") },
    @{ Name = "api-gateway"; Dependencies = @("spring-cloud-starter-gateway", "spring-cloud-starter-netflix-eureka-client", "spring-boot-starter-actuator", "spring-cloud-starter-circuitbreaker-reactor-resilience4j", "spring-boot-starter-webflux") },
    @{ Name = "identity-service"; Dependencies = @("spring-boot-starter-web", "spring-boot-starter-data-jpa", "com.h2database:h2", "spring-cloud-starter-netflix-eureka-client", "spring-boot-starter-actuator", "spring-cloud-starter-config", "spring-boot-starter-security", "org.projectlombok:lombok") },
    @{ Name = "customer-service"; Dependencies = @("spring-boot-starter-web", "spring-boot-starter-data-jpa", "com.h2database:h2", "spring-cloud-starter-netflix-eureka-client", "spring-boot-starter-actuator", "spring-cloud-starter-config", "org.projectlombok:lombok") },
    @{ Name = "account-service"; Dependencies = @("spring-boot-starter-web", "spring-boot-starter-data-jpa", "com.h2database:h2", "spring-cloud-starter-netflix-eureka-client", "spring-boot-starter-actuator", "spring-cloud-starter-config", "org.projectlombok:lombok", "spring-boot-starter-data-redis") },
    @{ Name = "transaction-service"; Dependencies = @("spring-boot-starter-web", "spring-boot-starter-data-jpa", "com.h2database:h2", "spring-cloud-starter-netflix-eureka-client", "spring-boot-starter-actuator", "spring-cloud-starter-config", "spring-cloud-starter-circuitbreaker-resilience4j", "org.springframework.kafka:spring-kafka", "org.projectlombok:lombok") },
    @{ Name = "notification-service"; Dependencies = @("spring-boot-starter-webflux", "spring-cloud-starter-netflix-eureka-client", "spring-boot-starter-actuator", "spring-cloud-starter-config", "org.springframework.kafka:spring-kafka", "org.projectlombok:lombok") }
)

foreach ($service in $services) {
    $name = $service.Name
    $deps = $service.Dependencies
    
    New-Item -ItemType Directory -Force -Path $name | Out-Null
    
    $depsXml = ""
    foreach ($dep in $deps) {
        if ($dep -match ":") {
            $parts = $dep -split ":"
            $groupId = $parts[0]
            $artifactId = $parts[1]
        } else {
            if ($dep -like "spring-cloud-*") {
                $groupId = "org.springframework.cloud"
            } elseif ($dep -like "spring-boot-*") {
                $groupId = "org.springframework.boot"
            } else {
                $groupId = "org.springframework.boot"
            }
            $artifactId = $dep
        }
        
        $depsXml += @"
        <dependency>
            <groupId>$groupId</groupId>
            <artifactId>$artifactId</artifactId>
        </dependency>
"@
    }

    $pomContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.rikkeibank</groupId>
        <artifactId>rikkeibank-microservices</artifactId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>

    <artifactId>$name</artifactId>
    <packaging>jar</packaging>
    <name>$name</name>
    <description>$name</description>

    <dependencies>
$depsXml
    </dependencies>
</project>
"@

    Set-Content -Path "$name\pom.xml" -Value $pomContent
    
    $pkgName = $name.Replace('-', '')
    $mainDir = "$name\src\main\java\com\rikkeibank\$pkgName"
    New-Item -ItemType Directory -Force -Path $mainDir | Out-Null
    New-Item -ItemType Directory -Force -Path "$name\src\main\resources" | Out-Null
    
    $className = (Get-Culture).TextInfo.ToTitleCase($name.Replace('-', ' ')).Replace(' ', '') + "Application"
    
    $appContent = @"
package com.rikkeibank.$pkgName;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class $className {
    public static void main(String[] args) {
        SpringApplication.run($className.class, args);
    }
}
"@
    Set-Content -Path "$mainDir\$className.java" -Value $appContent
    
    Set-Content -Path "$name\src\main\resources\application.yml" -Value "server:`n  port: 0`n"
}

Write-Host "Projects generated manually."
