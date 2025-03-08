# Use an official OpenJDK runtime as a parent image
FROM eclipse-temurin:17-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the target folder (Ensure the JAR is built before running Docker)
COPY target/StudentManagementSystem-0.0.1-SNAPSHOT.jar app.jar

# Expose the correct application port
EXPOSE 9090

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
