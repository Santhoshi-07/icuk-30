FROM maven:3.6.3-jdk-8 AS build

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the full source
COPY src ./src

# Skip tests to avoid DB connection errors
RUN mvn clean package -DskipTests

# Optional: If you want to include the JAR in final image
# FROM openjdk:8-jre
# COPY --from=build /app/target/*.jar app.jar
# ENTRYPOINT ["java", "-jar", "/app.jar"]

