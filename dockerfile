# Use Maven with JDK 8 (compatible with Spring Boot 2.2.2)
FROM maven:3.6.3-jdk-8 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Run tests using the "test" Spring profile
RUN mvn clean verify -Dspring.profiles.active=test

# Optional: Package JAR if needed
# RUN mvn package -DskipTests

# -------- Optional: Create slim runtime image --------
# FROM openjdk:8-jre-alpine
# COPY --from=build /app/target/*.jar app.jar
# ENTRYPOINT ["java", "-jar", "app.jar"]
