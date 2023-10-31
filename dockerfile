# Use the official maven/Java 17 image to create a build artifact.
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the current working directory inside the image
WORKDIR /app

# Copy the pom.xml file to download dependencies
COPY pom.xml .

# Download the dependencies before we build the app, this is a Docker trick 
# in order to keep the cached maven dependencies if they don't change
RUN mvn dependency:go-offline

# Copy the project source
COPY src src/

# Package the application
RUN mvn clean package -DskipTests

# Use OpenJDK 17 to run the WAR
FROM openjdk:17-slim

# Copy the WAR from the build stage
COPY --from=build /app/target/app-0.0.1-SNAPSHOT.war app.war

# Set the command to run your application using Spring Boot's embedded Tomcat.
CMD ["java", "-jar", "/app.war"]