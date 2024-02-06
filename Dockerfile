# Use an official Gradle image as the build environment
FROM gradle:7.3.3-jdk11 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the project files
COPY . .

# Build the Java application using Gradle
RUN gradle build

# Use an OpenJDK image as the runtime environment
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/NewJavaProject.jar ./app.jar

# Define the command to run the Java application
CMD ["java", "-jar", "app.jar"]