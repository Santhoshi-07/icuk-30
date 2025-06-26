FROM maven:3.6.3-jdk-8 AS build

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source
COPY src ./src

# Run tests with test profile
RUN mvn clean verify -Dspring.profiles.active=test
RUN mvn clean package -DskipTests
# Optional: build jar
# RUN mvn package -DskipTests

