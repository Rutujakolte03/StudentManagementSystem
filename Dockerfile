# Use Maven image to build the project
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy the POM file and source code
COPY pom.xml .
RUN mvn dependency:go-offline  # Download dependencies first
COPY src ./src

# Build the JAR
RUN mvn clean package -DskipTests

# Use OpenJDK for runtime
FROM openjdk:17
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
